module Api
  module V1
    class UsuariosController < ApplicationController
      #before_action :authorize_request, except: :create
      before_action :set_usuario, only: %i[show update delete]

      def index
        @usuarios = ApiNoticia::Models::Usuario.order(nome: :asc)
                                               .page(params[:page])
                                               .per(params[:per_page])
      end

      def show; end

      def create
        context = Usuario::Criar.call(usuario_params: usuario_params)
        @usuario = context.usuario
        if context.success?
          render :show
        else
          render json: formatar_erro(context, :usuario), status: context.status || 400
        end
      end

      def update
        context = Usuario::Atualizar.call(usuario_params: usuario_params,
                                          usuario: @usuario)
        @usuario = context.usuario
        if context.success?
          render :show
        else
          render json: formatar_erro(context, :usuario), status: context.status || 400
        end
      end

      def delete
        context = Usuario::Excluir.call(usuario: @usuario)
        @usuario = context.usuario
        if context.success?
          render :ok
        else
          render json: formatar_erro(context, :usuario), status: context.status || 400
        end
      end


      def set_usuario
        @usuario = ApiNoticia::Models::Usuario.find(params[:id])
      end 

      def usuario_params
        params.permit(:nome, :email, :password, :biografia)
      end
    end
  end
end
