class ModeratorController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_moderator!

  def dashboard
  end

  private

  def authorize_moderator!
    unless current_user.has_role?("Professor")
      redirect_to authenticated_root_path, alert: "Acesso não autorizado!"
    end
  end
end
