class StudentController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_student!

  def dashboard
  end

  private

  def authorize_student!
    unless current_user.has_role?("Aluno")
      redirect_to authenticated_root_path, alert: "Acesso não autorizado!"
    end
  end
end
