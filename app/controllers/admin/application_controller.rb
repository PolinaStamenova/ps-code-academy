module Admin
  class ApplicationController < ActionController::Base
    helper ActionText::Engine.helpers
    include Authenticate

    before_action :authorize_admin!, unless: -> { devise_controller? || shared_controller? }

    private

    def authorize_admin!
      redirect_to dashboard_path if current_user&.student?
    end

    def shared_controller?
      instance_of?(SharedController)
    end
  end
end
