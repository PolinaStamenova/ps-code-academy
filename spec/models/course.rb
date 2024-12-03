require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:video) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
