Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1, defaults: { format: :json } do
      resources :categorias
      resources :publicacoes
      resources :usuarios
    end
  end
  post '/auth/login', to: 'autenticacao#login'
end
