Rails.application.routes.draw do
  resources :items do
    resources :tracks
  end
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  post 'sign_up', to: 'registrations#create'
  get '/progress/:name', to: 'tracks#progress'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
