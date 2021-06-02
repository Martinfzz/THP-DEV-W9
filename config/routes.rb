Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show]
  end

  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'users/login',
      sign_out: 'users/logout',
      registration: 'users/signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
