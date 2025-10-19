Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users

  # Redirect users after login based on role
  authenticated :user do
    root to: "home#redirect_by_role", as: :authenticated_root
  end

  unauthenticated do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  # Admin area (Administrador)
  authenticate :user, lambda { |u| u.has_role?("Administrador") } do
    get '/admin/dashboard', to: 'admin#dashboard', as: :admin_dashboard
  end

  # Moderator area (Professor)
  authenticate :user, lambda { |u| u.has_role?("Professor") } do
    get '/moderator/dashboard', to: 'moderator#dashboard', as: :moderator_dashboard
  end

  # Student area (Aluno)
  authenticate :user, lambda { |u| u.has_role?("Aluno") } do
    get '/student/dashboard', to: 'student#dashboard', as: :student_dashboard
  end

  # Resource routes
  resources :questionnaires
end
