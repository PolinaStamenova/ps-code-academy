class ApplicationController < ActionController::Base
  include Authenticate

  before_action :authorize_student!, unless: :devise_controller?

  private

  def authorize_student!
    redirect_to admin_dashboard_path if current_user&.admin?
  end
end
