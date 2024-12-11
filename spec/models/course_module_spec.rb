require 'rails_helper'

RSpec.describe CourseModule, type: :model do
  describe 'associations' do
    it { should belong_to(:course) }
    it { should have_one_attached(:video) }
    it { should have_many_attached(:documents) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    describe 'validates the uniqueness of name (slug) within the scope of a course' do
      context 'when the name is already taken within the same course' do
        it 'is invalid' do
          user = create(:user)
          course = create(:course, user:, name: 'HTML Basics')
          create(:course_module, name: 'Introduction', course:)
          duplicate_course_module = build(:course_module, name: 'Introduction', course:)

          expect(duplicate_course_module).to_not be_valid
          expect(duplicate_course_module.errors.full_messages).to include(
            'Name already exists in the scope of this course. Please choose a different name.'
          )
        end
      end

      context 'when the name is taken in a different course' do
        it 'is valid' do
          user = create(:user)
          course = create(:course, user:, name: 'HTML Basics')
          create(:course_module, name: 'Introduction', course:)

          another_user = create(:user)
          another_course = create(:course, user: another_user, name: 'CSS Basics')
          unique_course_module = build(:course_module, name: 'Introduction', course: another_course)

          expect(unique_course_module).to be_valid
        end
      end
    end
  end
end
