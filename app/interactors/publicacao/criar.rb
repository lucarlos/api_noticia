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
      aws_response_img = Publicacao::AwsUploadImagemPrincipal.call(arquivo_imagem: context.publicacao.file_imagem,
                                                                   id_publicacao: last_id_return).response_aws
      if aws_response_img
        context.publicacao.url_imagem_principal = aws_response_img
        context.publicacao.save
      else
        context.fail!(status: 422)
      end
    end

    def last_id_return
      if ApiNoticia::Models::Publicacao.last.present? 
        ApiNoticia::Models::Publicacao.last.id + 1
      else
        1
      end
    end

  end
end
  