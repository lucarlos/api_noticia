module Api
  module V1
    class CategoriasController < ApplicationController
      before_action :set_categoria, only: %i[show update destroy]

      def index
        @categorias = ApiNoticia::Models::Categoria.all
      end

      def show; end

      def create
        context = Categoria::Criar.call(categoria_params: categoria_params)
        @categoria = context.categoria
        if context.success?
          render :show, status: 201
        else
          render json: formatar_erro(context, :categoria), status: context.status || 400
        end
      end

      def update
        context = Categoria::Atualizar.call(categoria_params: categoria_params,
                                              categoria: @categoria)
        @categoria = context.categoria
        if context.success?
          render :show, status: 200
        else
          render json: formatar_erro(context, :categoria), status: context.status || 400
        end
      end

      def destroy
        context = Categoria::Excluir.call(categoria: @categoria)

        if context.success?
          head :ok
        else
          render json: formatar_erro(context, :categoria), status: context.status || 400
        end
      end

      def set_categoria
        @categoria = ApiNoticia::Models::Categoria.find(params[:id])
      end

      def categoria_params
        params.permit(:id, :nome)
      end
    end
  end
end
