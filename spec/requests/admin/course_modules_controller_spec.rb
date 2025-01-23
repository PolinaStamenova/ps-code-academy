require 'rails_helper'

RSpec.describe Admin::CourseModulesController, type: :request do
  let(:user) { create(:user_admin) }
  let(:course) { create(:course, user:) }
  let(:course_module) { create(:course_module, course:) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_course_course_module_path(course)

      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get edit_admin_course_course_module_path(course, course_module)

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new CourseModule' do
        expect do
          post admin_course_course_modules_path(course), params: { course_module: attributes_for(:course_module) }
        end.to change(CourseModule, :count).by(1)
      end

      it 'redirects to the created course module' do
        post admin_course_course_modules_path(course), params: { course_module: attributes_for(:course_module) }

        expect(response).to redirect_to(admin_course_path(course))
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity response' do
        post admin_course_course_modules_path(course),
             params: { course_module: attributes_for(:course_module, name: nil) }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Name' } }

      it 'updates the requested course module' do
        put admin_course_course_module_path(course, course_module), params: { course_module: new_attributes }
        course_module.reload

        expect(course_module.name).to eq('Updated Name')
      end

      it 'redirects to the course module' do
        put admin_course_course_module_path(course, course_module), params: { course_module: new_attributes }
        course_module.reload

        expect(response).to redirect_to(admin_course_path(course))
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        put admin_course_course_module_path(course, course_module), params: { course_module: { name: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested course module' do
      course_module
      expect do
        delete admin_course_course_module_path(course, course_module)
      end.to change(CourseModule, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
