require 'rails_helper'

RSpec.describe Admin::ModuleLessonsController, type: :request do
  let(:user) { create(:user_admin) }
  let(:course) { create(:course, user:) }
  let(:course_module) { create(:course_module, course:) }
  let(:module_lesson) { create(:module_lesson, course_module:) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_course_course_module_module_lesson_path(course, course_module)
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get edit_admin_course_course_module_module_lesson_path(course, course_module, module_lesson)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:module_lesson) }
    let(:invalid_attributes) { { name: '' } }

    context 'with valid params' do
      it 'creates a new ModuleLesson' do
        expect do
          post admin_course_course_module_module_lessons_path(course, course_module),
               params: { module_lesson: valid_attributes }
        end.to change(ModuleLesson, :count).by(1)
      end

      it 'redirects to the created module lesson' do
        post admin_course_course_module_module_lessons_path(course, course_module),
             params: { module_lesson: valid_attributes }
        expect(response).to redirect_to(admin_course_path(course))
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "new" template)' do
        post admin_course_course_module_module_lessons_path(course, course_module),
             params: { module_lesson: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { name: 'Updated Name' } }

    context 'with valid params' do
      it 'updates the requested module lesson' do
        put admin_course_course_module_module_lesson_path(course, course_module, module_lesson),
            params: { module_lesson: new_attributes }
        module_lesson.reload

        expect(module_lesson.name).to eq('Updated Name')
      end

      it 'redirects to the module lesson' do
        put admin_course_course_module_module_lesson_path(course, course_module, module_lesson),
            params: { module_lesson: new_attributes }
        module_lesson.reload

        expect(response).to redirect_to(admin_course_path(course))
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        put admin_course_course_module_module_lesson_path(course, course_module, module_lesson),
            params: { module_lesson: { name: '' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested module lesson and redirects to the course' do
      module_lesson
      expect do
        delete admin_course_course_module_module_lesson_path(course, course_module, module_lesson)
      end.to change(ModuleLesson, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
