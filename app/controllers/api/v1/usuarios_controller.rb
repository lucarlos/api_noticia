module Api
  module V1
    class UsuariosController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :set_usuario, only: %i[show update destroy]
      before_action :usuario_permissoes, except: :create

      def show; end

      def create
        context = Usuario::Criar.call(usuario_params: usuario_params_create)
        @usuario = context.usuario
        if context.success?
          render :show
        else
          render json: formatar_erro(context, :usuario), status: context.status || 400
        end
      end

      def update
        context = Usuario::Atualizar.call(usuario_params: usuario_params_update,
                                          usuario: @usuario)
        @usuario = context.usuario
        if context.success?
          render :show
        else
          render json: formatar_erro(context, :usuario), status: context.status || 400
        end
      end

      def destroy
        context = Usuario::Excluir.call(usuario: @usuario)
        @usuario = context.usuario
        if context.success?
          head :ok
        else
          render json: formatar_erro(context, :usuario), status: context.status || 400
        end
      end

      private

      def set_usuario
        @usuario = ApiNoticia::Models::Usuario.find(params[:id])
      end

      def usuario_params_create
        params.permit(:nome, :email, :password, :ativo, :cargo, :biografia)
      end

      def usuario_params_update
        params.permit(:email, :ativo, :cargo, :biografia)
      end

      def usuario_permissoes
        unless @current_user.cargo == ApiNoticia::Models::Usuario.cargos[:publico] && @current_user.id == @usuario.id
          unless @current_user.cargo == ApiNoticia::Models::Usuario.cargos[:moderador]
            unless @current_user.cargo == ApiNoticia::Models::Usuario.cargos[:administrador]
              render json: { erro: "Acesso Negado" }, status: 403
            end
          end
        end
      end
    end
  end
end
