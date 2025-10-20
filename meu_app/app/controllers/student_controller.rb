class StudentController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_student!

  def dashboard; end

  private
  def authorize_student!
    redirect_to authenticated_root_path unless current_user.has_role?(:Aluno)
  end
end
