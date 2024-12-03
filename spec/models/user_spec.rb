require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_length_of(:last_name).is_at_least(2) }

    describe 'validating alphabetic characters for names' do
      context 'when first_name contains only alphabetic characters' do
        let(:user) do
          User.new(first_name: 'Polina', last_name: 'Stamenova', password: 'polina123', email: 'polina@example.com')
        end

        it { expect(user).to be_valid }
      end

      context 'when first_name contains non-alphabetic characters' do
        let(:user) do
          User.new(first_name: 'Polina555', last_name: 'Stamenova', password: 'polina123', email: 'polina@example.com')
        end

        it { expect(user).to_not be_valid }
      end
    end

    describe 'email validations' do
      it { should validate_presence_of(:email) }

      let(:user) { User.new(first_name: 'Johnny', last_name: 'Depp', password: 'johnny123', email:) }

      context 'when email is valid' do
        let(:email) { 'johnny@example.com' }

        it { expect(user).to be_valid }
      end

      context 'when email is invalid' do
        invalid_emails = [
          'johnnydepp',
          '@johnny.com',
          'johnny@.com',
          'johnny@example',
          'johnny@example,com',
          'johnny@example@example.com'
        ]

        invalid_emails.each do |email|
          let(:email) { email }

          it { expect(user).to_not be_valid }
        end
      end
    end
  end

  describe 'method' do
    let(:user) do
      User.create!(first_name: 'Johnny', last_name: 'Depp', password: 'johnny123', email: 'johnny@example.com')
    end

    context '#student?' do
      it 'returns true' do
        expect(user.student?).to be_truthy
      end
    end

    context '#admin?' do
      it 'returns true' do
        user.update!(role: 'admin')

        expect(user.admin?).to be_truthy
      end
    end
  end
end
