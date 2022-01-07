module Categoria
  class Excluir
    include Interactor
    include Interactor::Contracts

    expects do
      required(:categoria).filled
    end

    on_breach do |breaches|
      mensagem = []
      breaches.each do |breach|
        mensagem << breach.messages
      end
      context.fail!(mensagem: mensagem.join(', '))
    end

    def call
      context.fail!(status: 422) unless context.categoria.destroy
    end
  end
end
