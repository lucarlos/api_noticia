module Publicacao
  class Atualizar
    include Interactor
    include Interactor::Contracts

    expects do
      required(:publicacao_params).filled
      required(:publicacao)
    end

    on_breach do |breaches|
      mensagem = []
      breaches.each do |breach|
        mensagem << breach.messages
      end
      context.fail!(mensagem: mensagem.join(', '))
    end

    def call
      atribuir_nova_url_imagem_aws
      context.publicacao.assign_attributes(context.publicacao_params)
      if context.publicacao_params[:url_imagem_principal]
        context.publicacao.save
      else
        context.fail!(status: 422)
      end
    end
    
    def atribuir_nova_url_imagem_aws
      if context.publicacao_params[:file_imagem].present?
        context.publicacao_params[:url_imagem_principal] = Publicacao::AwsUploadImagemPrincipal
                                                  .call(arquivo_imagem: context.publicacao_params[:file_imagem],
                                                        id_publicacao: context.publicacao.id).response_aws
      end
    end

  end
end