Rails.application.routes.draw do
  get 'help', action: :show, controller: 'help'

  resources :pings, only: %i(create)
end
