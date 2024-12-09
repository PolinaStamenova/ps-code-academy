require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: 'Test action'
    end
  end

  context 'when user is an admin' do
    let(:admin) { create(:user, role: 'admin') }

    before do
      sign_in admin
      get :index
    end

    it 'redirects to admin dashboard' do
      expect(response).to redirect_to(admin_dashboard_path)
    end
  end

  context 'when user is a student' do
    let(:student) { create(:user, role: 'student') }

    before do
      sign_in student
      get :index
    end

    it 'does not redirect' do
      expect(response).to have_http_status(:ok)
    end
  end
end
