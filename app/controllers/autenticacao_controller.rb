class AutenticacaoController < ApplicationController
  before_action :authorize_request, except: :login
  def login
    @usuario = ApiNoticia::Models::Usuario.find_by(nome: params[:nome])

    if @usuario&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @usuario.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), id: @usuario.id,
                      nome: @usuario.nome, email: @usuario.email, biografia: @usuario.biografia}, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:nome, :password)
  end
end

