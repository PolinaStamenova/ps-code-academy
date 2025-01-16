require 'rails_helper'

RSpec.describe CoursesController, type: :request do
  let!(:user) { create(:user) }
  let!(:courses) { create_list(:course, 3, user:, active: true) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    let!(:enrolled_courses) { create_list(:enrolled_course, 3, user:) }
    let!(:not_enrolled_courses) { create_list(:active_course, 3, user:) }

    it 'returns a successful response' do
      get courses_path
      expect(response).to have_http_status(:success)
    end

    context 'when enrolled filter is applied' do
      it 'returns only enrolled active courses' do
        get courses_path(filter: :enrolled)

        enrolled_courses.each do |course|
          expect(response.body).to include(course.name)
        end

        not_enrolled_courses.each do |course|
          expect(response.body).not_to include(course.name)
        end
      end
    end

    context 'when not_enrolled filter is applied' do
      it 'returns only not enrolled active courses' do
        get courses_path(filter: :not_enrolled)

        not_enrolled_courses.each do |course|
          expect(response.body).to include(course.name)
        end

        enrolled_courses.each do |course|
          expect(response.body).not_to include(course.name)
        end
      end
    end

    context 'when all filter is applied' do
      it 'returns all active courses' do
        get courses_path(filter: :all)

        not_enrolled_courses.each do |course|
          expect(response.body).to include(course.name)
        end

        enrolled_courses.each do |course|
          expect(response.body).to include(course.name)
        end
      end
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      course = create(:course, user:, active: true)
      get course_path(course)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /enrolled' do
    let!(:courses_not_started) { create_list(:course_not_started, 3, user:) }
    let!(:courses_started) { create_list(:course_started, 3, user:) }
    let!(:courses_completed) { create_list(:course_completed, 3, user:) }

    it 'returns a successful response' do
      get enrolled_courses_path
      expect(response).to have_http_status(:success)
    end

    context 'when not_started filter is applied' do
      it 'returns only NOT started active courses' do
        get enrolled_courses_path(filter: :not_started)

        courses_not_started.each do |course|
          expect(response.body).to include(course.name)
        end

        courses_started.each do |course|
          expect(response.body).not_to include(course.name)
        end

        courses_completed.each do |course|
          expect(response.body).not_to include(course.name)
        end
      end
    end

    context 'when started filter is applied' do
      it 'returns only started active courses' do
        get enrolled_courses_path(filter: :started)

        courses_started.each do |course|
          expect(response.body).to include(course.name)
        end

        courses_not_started.each do |course|
          expect(response.body).not_to include(course.name)
        end

        courses_completed.each do |course|
          expect(response.body).not_to include(course.name)
        end
      end
    end

    context 'when completed filter is applied' do
      it 'returns only completed active courses' do
        get enrolled_courses_path(filter: :completed)

        courses_completed.each do |course|
          expect(response.body).to include(course.name)
        end

        courses_not_started.each do |course|
          expect(response.body).not_to include(course.name)
        end

        courses_started.each do |course|
          expect(response.body).not_to include(course.name)
        end
      end
    end

    context 'when all filter is applied' do
      it 'returns all active courses' do
        get enrolled_courses_path(filter: :all)

        courses_completed.each do |course|
          expect(response.body).to include(course.name)
        end

        courses_not_started.each do |course|
          expect(response.body).to include(course.name)
        end

        courses_started.each do |course|
          expect(response.body).to include(course.name)
        end
      end
    end
  end

  describe 'GET /purchase' do
    it 'returns a successful response' do
      course = create(:active_course, user:)
      post purchase_course_path(course)

      expect(response).to have_http_status(:success)
    end
  end
end
