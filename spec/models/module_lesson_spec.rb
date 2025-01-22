require 'rails_helper'

RSpec.describe ModuleLesson, type: :model do
  describe 'associations' do
    it { should belong_to(:course_module) }
    it { should have_one_attached(:video) }
    it { should have_many_attached(:documents) }
    it { should have_rich_text(:content) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    describe 'validates the uniqueness of name (slug) within the scope of a course module' do
      context 'when the name is already taken within the same course module' do
        it 'is invalid' do
          user = create(:user_admin)
          course_module = create(:course_module, course: create(:course, user:))
          create(:module_lesson, name: 'Introduction', course_module:)

          duplicate_module_lesson = build(:module_lesson, name: 'Introduction', course_module:)

          expect(duplicate_module_lesson).to_not be_valid
          expect(duplicate_module_lesson.errors.full_messages).to include(
            'Name already exists in the scope of this course module. Please choose a different name.'
          )
        end
      end

      context 'when the name is taken in a different course module' do
        it 'is valid' do
          user = create(:user_admin)
          course_module = create(:course_module, course: create(:course, user:))
          create(:module_lesson, name: 'Introduction', course_module:)

          another_course_module = create(:course_module, course: create(:course, user:))
          unique_course_module = build(:module_lesson, name: 'Introduction', course_module: another_course_module)

          expect(unique_course_module).to be_valid
        end
      end
    end
  end
end
