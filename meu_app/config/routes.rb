Rails.application.routes.draw do
  # Rotas do Devise
  devise_for :users

  # Rota para usuários não autenticados
  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  # Rota para usuários autenticados - redireciona pelo papel (role)
  authenticated :user do
    root to: "home#redirect_by_role", as: :authenticated_root
  end

  # Área do Administrador
  authenticate :user, lambda { |u| u.has_role?("Administrador") } do
    get '/admin/dashboard', to: 'admin#dashboard', as: :admin_dashboard
  end

  # Área do Professor
  authenticate :user, lambda { |u| u.has_role?("Professor") } do
    get '/moderator/dashboard', to: 'moderator#dashboard', as: :moderator_dashboard
  end

  # Área do Aluno
  authenticate :user, lambda { |u| u.has_role?("Aluno") } do
    get '/student/dashboard', to: 'student#dashboard', as: :student_dashboard
  end

  # Recursos Comuns
  resources :questionnaires
end
