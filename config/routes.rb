Rails.application.routes.draw do
  get 'help', action: :show, controller: 'help'

  resources :ping, only: %i(create)
end
