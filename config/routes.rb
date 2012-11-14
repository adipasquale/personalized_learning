PersonalizedLearning::Application.routes.draw do

  resources :users, only: [:new, :show, :create, :destroy, :edit, :update] do
    member do
      put :answer_task
      put :answer_questionnaire
      get :edit_traits
      put :update_traits
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :traits, only: [:new, :edit, :update, :create, :destroy]
  resources :questionnaires

  root :to => 'sessions#new'

  match '/home', to: "users#home"
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/admin',   to: 'admin#home'

end
