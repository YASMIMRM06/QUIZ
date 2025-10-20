class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard; end

  private
  def authorize_admin!
    redirect_to authenticated_root_path unless current_user.has_role?(:Administrador)
  end
end
