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

    describe 'validates the format of video' do
      context 'when the video format is invalid' do
        it 'is invalid' do
          course = build(:course)
          course.video.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'document.pdf')),
                              filename: 'document.pdf', content_type: 'document/pdf')

          expect(course).to_not be_valid
          expect(course.errors.full_messages).to include('Video must be a valid video format (mp4, avi, or webm)')
        end
      end

      context 'when the video format is valid' do
        it 'is valid' do
          course = build(:course_with_video)

          expect(course).to be_valid
        end
      end
    end
  end
end
