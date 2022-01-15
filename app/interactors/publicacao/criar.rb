module Publicacao
  class Criar
    include Interactor
    include Interactor::Contracts

    expects do
      required(:publicacao_params).filled
    end

    on_breach do |breaches|
      mensagem = []
      breaches.each do |breach|
        mensagem << breach.messages
      end
      context.fail!(mensagem: mensagem.join(', '))
    end

    def call
      context.publicacao = ApiNoticia::Models::Publicacao.new(context.publicacao_params)      
      arquivo_imagem = context.publicacao.file_imagem
      last_id = ApiNoticia::Models::Publicacao.last.id + 1
      aws_response_img = Publicacao::AwsUploadImagemPrincipal.call(arquivo_imagem: arquivo_imagem, id_publicacao: last_id).response_aws

      if aws_response_img
        context.publicacao.url_imagem_principal = aws_response_img
        context.publicacao.save
      else
        context.fail!(status: 422)
      end
    end

  end
end
  