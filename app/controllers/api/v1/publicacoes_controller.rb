module Api
  module V1
    class PublicacoesController < ApplicationController
      before_action :set_publicacao, only: %i[show update destroy]

      def index
        @publicacoes = ApiNoticia::Models::Publicacao.all
      end

      def create
        context = Publicacao::Criar.call(publicacao_params: publicacao_params)
        @publicacao = context.publicacao
        if context.success?
          render :show, status: 201
        else
          render json: formatar_erro(context, :publicacao), status: context.status || 400
        end
      end

      private

      def set_publicacao
        @publicacao = ApiNoticia::Models::Publicacao.find(params[:id])
      end

      def publicacao_params
        params.permit(:id, :titulo, :subtitulo, :conteudo, :imagem_principal,
                      publicacoes_categorias_attributes: [:id, :publicacao_id, :categoria_id])
      end
    end
  end
end