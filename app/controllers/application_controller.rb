class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery unless: -> { request.format.json? }

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      if @decoded
        @current_user = ApiNoticia::Models::Usuario.find(@decoded[:user_id])
      else
        render json: { errors: 'Não autenticado!' }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
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
