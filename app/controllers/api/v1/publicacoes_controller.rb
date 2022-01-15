module Api
  module V1
    class PublicacoesController < ApplicationController
      before_action :set_publicacao, only: %i[show update destroy]

      def index
        @publicacoes = ApiNoticia::Models::Publicacao.all
      end

      def show; end

      def create
        context = Publicacao::Criar.call(publicacao_params: publicacao_params)
        @publicacao = context.publicacao
        
        if context.success?
          render :show, status: 201
        else
          render json: formatar_erro(context, :publicacao), status: context.status || 400
        end
      end

      def update
        context = Publicacao::Atualizar.call(publicacao_params: publicacao_params,
                                             publicacao: @publicacao)
        @publicacao = context.publicacao
        if context.success?
          render :show, status: 200
        else
          render json: formatar_erro(context, :publicacao), status: context.status || 400
        end
      end

      def destroy
        context = Publicacao::Excluir.call(publicacao: @publicacao)

        if context.success?
          head :ok
        else
          render json: formatar_erro(context, :publicacao), status: context.status || 400
        end
      end

      private
      
      def set_publicacao
        @publicacao = ApiNoticia::Models::Publicacao.find(params[:id])
      end

      def publicacao_params
        params.permit(:id, :titulo, :subtitulo, :conteudo, :file_imagem,
                      publicacoes_categorias_attributes: [:id, :publicacao_id, :categoria_id])
      end
    end
  end
end