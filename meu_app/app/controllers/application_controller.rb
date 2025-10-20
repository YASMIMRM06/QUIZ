class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?

  # 🔹 Aplica Pundit apenas nos controladores do seu app (não nos do Devise)
  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, unless: :skip_pundit?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  # 🔹 Método inteligente para ignorar Devise e algumas rotas específicas
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(active_storage|rails_admin|devise)/
  end
end
