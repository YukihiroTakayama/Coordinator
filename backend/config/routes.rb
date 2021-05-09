Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :items, param: :code
      resources :genres
      resources :coordinates, except: [:show] do
        collection do
          get ':id/edit', to: 'coordinates#edit'
          get ':token', to: 'coordinates#show'
        end
      end
      resources :parts, param: :token
    end
  end
end
