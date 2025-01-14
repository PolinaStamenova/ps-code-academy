require 'rails_helper'

RSpec.describe Admin::CoursesController, type: :request do
  let(:user) { create(:user_admin) }
  let(:course) { create(:course, user:) }

  before do
    sign_in user
  end

  describe 'GET /active_courses' do
    it 'returns http success' do
      get admin_active_courses_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /draft_courses' do
    it 'returns http success' do
      get admin_draft_courses_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get admin_course_path(course)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_admin_course_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_params) { { course: { name: 'New Course', description: 'Course Description' } } }

      it 'creates a new course' do
        expect do
          post admin_courses_path, params: valid_params
        end.to change(Course, :count).by(1)
      end

      it 'redirects to the created course' do
        post admin_courses_path, params: valid_params
        expect(response).to redirect_to(admin_course_path(Course.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { course: { name: '', description: '' } } }

      it 'does not create a new course' do
        expect do
          post admin_courses_path, params: invalid_params
        end.not_to change(Course, :count)
      end

      it 'renders the new template' do
        post admin_courses_path, params: invalid_params
        expect(response.body).to include('Create Course')
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_admin_course_path(course)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'Updated Course', description: 'Updated Description' } }

      it 'updates the course' do
        patch admin_course_path(course), params: { course: new_attributes }
        course.reload
        expect(course.name).to eq('Updated Course')
        expect(course.description).to eq('Updated Description')
      end

      it 'redirects to the course' do
        patch admin_course_path(course), params: { course: new_attributes }
        course.reload

        expect(response).to redirect_to(admin_course_path(course))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: '', description: '' } }

      it 'does not update the course' do
        patch admin_course_path(course), params: { course: invalid_attributes }
        course.reload
        expect(course.name).not_to eq('')
        expect(course.description).not_to eq('')
      end

      it 'renders the edit template' do
        patch admin_course_path(course), params: { course: invalid_attributes }
        expect(response.body).to include('Update Course')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the course' do
      course_to_delete = create(:course, user:)
      expect do
        delete admin_course_path(course_to_delete)
      end.to change(Course, :count).by(-1)
    end

    it 'redirects to the courses list' do
      delete admin_course_path(course)
      expect(response).to redirect_to(admin_courses_path)
    end
  end

  describe 'POST /publish' do
    it 'publishes the course' do
      course = create(:course, user:)
      post publish_admin_course_path(course)
      course.reload

      expect(course.active).to be(true)
    end

    it 'redirects to the course' do
      post publish_admin_course_path(course)
      expect(response).to redirect_to(admin_active_courses_path)
    end
  end

  describe 'POST /unpublish' do
    it 'publishes the course' do
      course = create(:course, user:, active: true)
      post unpublish_admin_course_path(course)
      course.reload

      expect(course.active).to be(false)
    end

    it 'redirects to the course' do
      post unpublish_admin_course_path(course)
      expect(response).to redirect_to(admin_draft_courses_path)
    end
  end
end
