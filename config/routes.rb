PersonalizedLearning::Application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks

  root :to => 'sessions#new'

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/admin',   to: 'admin#index'

end
