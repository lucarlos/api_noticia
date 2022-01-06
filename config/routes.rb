Rails.application.routes.draw do
  namespace :api, default: { format: :json } do
    namespace :v1, default: { format: :json } do
      resources :categorias
    end
  end
end
