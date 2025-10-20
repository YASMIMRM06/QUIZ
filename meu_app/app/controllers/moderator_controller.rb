class ModeratorController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_moderator!

  def dashboard; end

  private
  def authorize_moderator!
    redirect_to authenticated_root_path unless current_user.has_role?(:Professor)
  end
end
