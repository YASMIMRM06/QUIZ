class HomeController < ApplicationController
  before_action :authenticate_user!

  def redirect_by_role
    if current_user.has_role?("Administrador")
      redirect_to admin_dashboard_path
    elsif current_user.has_role?("Professor")
      redirect_to moderator_dashboard_path
    else
      redirect_to student_dashboard_path
    end
  end
end
