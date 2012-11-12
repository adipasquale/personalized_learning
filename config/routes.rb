PersonalizedLearning::Application.routes.draw do

  resources :users, only: [:new, :show, :create, :destroy, :edit, :update] do
    member do
      put :answer_task
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :traits, only: [:new, :edit, :update, :create, :destroy]

  root :to => 'sessions#new'

  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/admin',   to: 'admin#index'

end
