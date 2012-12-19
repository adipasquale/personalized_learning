PersonalizedLearning::Application.routes.draw do

  resources :users, only: [:new, :show, :create, :destroy, :edit, :update] do
    member do
      put :answer_task
      put :answer_questionnaire
      get :edit_traits
      put :update_traits
      get :move_to_next_step
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :traits, only: [:new, :edit, :update, :create, :destroy]
  resources :questionnaires
  match "/answers_for_tasks", to: "answers#for_tasks"
  match "/answers_for_questionnaires", to: "answers#for_questionnaires"

  root :to => 'sessions#new'

  match '/home', to: "users#home"
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/admin',   to: 'admin#home'

end
