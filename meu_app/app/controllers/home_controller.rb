class HomeController < ApplicationController
  before_action :authenticate_user!

  def redirect_by_role
    if current_user.has_role?(:Administrador)
      redirect_to admin_dashboard_path
    elsif current_user.has_role?(:Professor)
      redirect_to moderator_dashboard_path
    elsif current_user.has_role?(:Aluno)
      redirect_to student_dashboard_path
    else
      reset_session
      redirect_to new_user_session_path, alert: "Papel não definido!"
    end
  end
end
