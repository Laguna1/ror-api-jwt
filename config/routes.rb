Rails.application.routes.draw do
  post 'sign_up', to: 'registrations#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
