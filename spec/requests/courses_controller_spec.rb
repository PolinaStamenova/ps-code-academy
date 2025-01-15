require 'rails_helper'

RSpec.describe CoursesController, type: :request do
  let!(:user) { create(:user) }
  let!(:courses) { create_list(:course, 3, user:, active: true) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get courses_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      course = create(:course, user:, active: true)
      get course_path(course)
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /purchase' do
    it 'returns a successful response' do
      course = create(:course, user:)
      get purchase_course_path(course)
      expect(response).to have_http_status(:success)
    end
  end
end
