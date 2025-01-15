require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:item) }
  end

  describe 'scopes' do
    describe '.pending' do
      it 'returns purchases with status pending' do
        purchase = create(:purchase, status: :pending)

        expect(Purchase.pending).to eq([purchase])
      end
    end

    describe '.succeeded' do
      it 'returns purchases with status succeeded' do
        purchase = create(:purchase, status: :succeeded)

        expect(Purchase.succeeded).to eq([purchase])
      end
    end
  end
end
