require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do
  controller(Admin::ApplicationController) do
    def index
      render plain: 'Admin action'
    end
  end

  context 'when user is a student' do
    let(:student) { create(:user) }

    before do
      sign_in student
      get :index
    end

    it 'redirects to student dashboard' do
      expect(response).to redirect_to(dashboard_path)
    end
  end

  context 'when user is an admin' do
    let(:admin) { create(:user_admin) }

    before do
      sign_in admin
      get :index
    end

    it 'does not redirect' do
      expect(response).to have_http_status(:ok)
    end
  end
end
