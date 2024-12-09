require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:video) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'validates the uniqueness of name (slug)' do
      user = create(:user)
      create(:course, user:, name: 'HTML Basics')
      duplicate_course = build(:course, user:, name: 'HTML Basics')

      expect(duplicate_course).to_not be_valid
      expect(duplicate_course.errors.full_messages).to include('Name has already been taken. Please choose a different name.') # rubocop:disable Layout/LineLength
    end
  end
end
