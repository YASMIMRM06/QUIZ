Rails.application.routes.draw do
  get 'home/index'
  resources :question_options
  resources :questions
  resources :questionnaires
  devise_for :users

  resources :questionnaires do
    member do
      get :respond
      get 'question/:id', to: 'questionnaires#question', as: :question
      post 'question/:id/answer', to: 'questionnaires#submit_answer', as: :submit_answer
      get :result
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
