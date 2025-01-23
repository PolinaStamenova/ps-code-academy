class ApplicationController < ActionController::Base
  include Authenticate
  helper ActionText::Engine.helpers

  before_action :authorize_student!, unless: -> { devise_controller? || shared_controller? }

  private

  def authorize_student!
    redirect_to admin_dashboard_path if current_user&.admin?
  end

  def shared_controller?
    instance_of?(SharedController)
  end
end
