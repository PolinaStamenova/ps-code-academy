require 'rails_helper'

RSpec.describe CourseModule, type: :model do
  describe 'associations' do
    it { should belong_to(:course) }
    it { should have_one_attached(:video) }
    it { should have_many_attached(:documents) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
