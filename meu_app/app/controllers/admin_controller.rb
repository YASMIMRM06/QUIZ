class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
  end

  private

  def authorize_admin!
    unless current_user.has_role?("Administrador")
      redirect_to authenticated_root_path, alert: "Acesso não autorizado!"
    end
  end
end
