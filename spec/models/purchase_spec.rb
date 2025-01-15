require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:item) }
  end
end
