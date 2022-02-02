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
      context.fail!(status: 422) unless context.publicacao.save
    end

    def atribuir_nova_url_imagem_aws
      if context.publicacao_params[:file_imagem].present?
        response_aws = Publicacao::AwsUploadImagemPrincipal.call(arquivo_imagem: context.publicacao_params[:file_imagem],
                                                  id_publicacao: context.publicacao.id).response_aws
        if response_aws
          context.publicacao_params[:url_imagem_principal] = response_aws
        end
      end
    end

  end
end