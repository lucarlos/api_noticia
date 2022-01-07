module Categoria
  class Atualizar
    include Interactor
    include Interactor::Contracts

    expects do
      required(:categoria_params).filled
      required(:categoria)
    end

    on_breach do |breaches|
      mensagem = []
      breaches.each do |breach|
        mensagem << breach.messages
      end
      context.fail!(mensagem: mensagem.join(', '))
    end

    def call
      context.categoria.assign_attributes(context.categoria_params)
      context.fail!(status: 422) unless context.categoria.save
    end
  end
end