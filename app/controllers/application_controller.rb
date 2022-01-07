class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery unless: -> { request.format.json? }

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def formatar_erro(context, objeto)
    if context.mensagem.present?
      { mensagem: context.mensagem }
    elsif context.send(objeto)&.errors&.present?
      context.send(objeto).errors.full_messages
    else
      { mensagem: 'Houve um erro ao atualizar os dados. Por favor tente novamente' }
    end
  end
end
