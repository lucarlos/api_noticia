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
      context.fail!(status: 422) unless context.publicacao.save
    end

  end
end
  