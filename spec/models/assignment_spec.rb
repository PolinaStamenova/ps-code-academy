require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'associations' do
    it { should belong_to(:course_module) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:content) }

    describe 'validate_github_repo_link_format' do
      let(:course_module) { create(:course_module) }

      context 'when github_repo_link is valid' do
        it 'does not add any error' do
          assignment = Assignment.new(github_repo_link: 'https://github.com/TestName/repo', course_module:)

          assignment.save

          assignment.errors[:github_repo_link].should be_empty
        end
      end

      context 'when github_repo_link is invalid' do
        it 'adds an error' do
          assignment = Assignment.new(github_repo_link: 'github.com/TestName/repo', course_module:)

          assignment.save

          error_message = 'is invalid. Please provide a valid GitHub repository link.'
          assignment.errors[:github_repo_link].should include(error_message)
        end
      end
    end
  end

  describe 'estimated_time_in_hours' do
    let(:course_module) { create(:course_module) }

    it 'returns the estimated time in hours' do
      assignment = Assignment.new(estimated_time_in_minutes: 120, course_module:)

      expect(assignment.estimated_time_in_hours).to eq(2)
    end

    it 'returns nil when estimated_time_in_minutes is nil' do
      assignment = Assignment.new(estimated_time_in_minutes: nil, course_module:)

      expect(assignment.estimated_time_in_hours).to be_nil
    end
  end
end
