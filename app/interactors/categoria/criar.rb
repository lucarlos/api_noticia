module Categoria
  class Criar
    include Interactor
    include Interactor::Contracts

    expects do
      required(:categoria_params).filled
    end

    on_breach do |breaches|
      mensagem = []
      breaches.each do |breach|
        mensagem << breach.messages
      end
      context.fail!(mensagem: mensagem.join(', '))
    end

    def call
      context.categoria = ApiNoticia::Models::Categoria.new(context.categoria_params)
      context.fail!(status: 422) unless context.categoria.save
    end
  end
end
