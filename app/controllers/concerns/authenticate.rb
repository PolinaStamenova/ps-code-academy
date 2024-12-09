module Authenticate
  extend ActiveSupport::Concern

  included do
    # Callbacks
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email password])
  end
end
