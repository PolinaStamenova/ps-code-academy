require 'rails_helper'

RSpec.describe StripeCheckoutSessionService, type: :service do
  let(:user) { create(:user, email: 'john@test.com') }
  let(:course) { create(:course, name: 'Ruby Course') }
  let(:purchase) { create(:purchase, user:, item: course, amount_in_cents: 2000, quantity: 1) }

  let(:success_url) { 'http://test.host/purchases/success' }
  let(:cancel_url) { 'http://test.host/purchases/cancel' }

  subject { described_class.new(purchase, success_url:, cancel_url:) }

  describe '#call' do
    it 'creates a Stripe Checkout Session with correct parameters' do
      allow(Stripe::Checkout::Session).to receive(:create).and_return(OpenStruct.new(id: 'test_session_id', url: 'https://checkout.stripe.com/test_url')) # rubocop:disable Style/OpenStructUse,Layout/LineLength

      session = subject.call

      expect(Stripe::Checkout::Session).to have_received(:create).with(
        client_reference_id: user.id,
        customer_email: user.email,
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'usd',
            product_data: {
              name: "#{course.name} - by #{user.full_name}"
            },
            unit_amount: 2000
          },
          quantity: 1
        }],
        mode: 'payment',
        success_url:,
        cancel_url:,
        metadata: {
          purchase_id: purchase.id
        }
      )

      expect(session.id).to eq('test_session_id')
      expect(session.url).to eq('https://checkout.stripe.com/test_url')
    end
  end
end
