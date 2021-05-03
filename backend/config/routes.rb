Rails.application.routes.draw do
  get 'genres/index'
  scope :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :items, param: :code
      resources :genres
      resources :coordinates
    end
  end
end
