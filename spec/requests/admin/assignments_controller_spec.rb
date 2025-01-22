require 'rails_helper'

RSpec.describe Admin::AssignmentsController, type: :request do
  let(:user) { create(:user_admin) }
  let(:course) { create(:course, user:) }
  let(:course_module) { create(:course_module, course:) }
  let(:valid_attributes) do
    {
      name: 'Test Assignment',
      content: 'Test Content',
      github_repo_link: 'https://github.com/test/repo',
      estimated_time_in_minutes_hours: '1',
      estimated_time_in_minutes_minutes: '30'
    }
  end

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_course_course_module_assignment_path(course, course_module)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Assignment' do
        expect do
          post admin_course_course_module_assignments_path(course, course_module),
               params: { assignment: valid_attributes }
        end.to change(Assignment, :count).by(1)
      end

      it 'redirects to the course with a success notice' do
        post admin_course_course_module_assignments_path(course, course_module),
             params: { assignment: valid_attributes }

        expect(response).to redirect_to([:admin, course])
        expect(flash[:notice]).to eq('Assignment was successfully created.')
      end
    end

    context 'with invalid params' do
      before do
        post admin_course_course_module_assignments_path(course, course_module),
             params: { assignment: valid_attributes.merge(name: '') }
      end

      it 'renders the new template with unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders the new template' do
        expect(response.body).to include('Create an Assignment')
      end
    end
  end
end
