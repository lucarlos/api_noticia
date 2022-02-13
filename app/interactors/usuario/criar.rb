module Usuario
  class Criar
    include Interactor
    include Interactor::Contracts

    expects do
      required(:usuario_params).filled
    end

    on_breach do |breaches|
      mensagem = []
      breaches.each do |breach|
        mensagem << breach.messages
      end
      context.fail!(mensagem: mensagem.join(', '))
    end

    def call
      context.usuario = ApiNoticia::Models::Usuario.new(context.usuario_params)
      context.fail!(status: 422) unless context.usuario.save
    end
  end
end
