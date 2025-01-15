require 'rails_helper'
require 'ostruct'

RSpec.describe PurchasesController, type: :request do
  let(:user) { create(:user) }
  let(:course) { create(:course, active: true) }

  before do
    sign_in user
  end

  describe 'POST /create' do
    context 'when user is already enrolled in the course' do
      before do
        create(:purchase, user:, item: course)
      end

      it 'does not create a new Purchase and redirects with an alert' do
        expect do
          post purchases_path, params: { purchase: { course_id: course.id } }
        end.not_to change(Purchase, :count)

        expect(response).to redirect_to(course_path(course))
        expect(flash[:alert]).to eq('You have already purchased this course.')
      end
    end

    context 'when user is not yet enrolled in the course' do
      it 'creates a new Purchase and redirects to Stripe session URL' do
        allow_any_instance_of(StripeCheckoutSessionService).to receive(:call).and_return(OpenStruct.new( # rubocop:disable Style/OpenStructUse
                                                                                           id: 'session_id', url: 'https://stripe.com/session'
                                                                                         ))

        expect do
          post purchases_path, params: { purchase: { course_id: course.id } }
        end.to change(Purchase, :count).by(1)

        expect(Purchase.last.stripe_session_id).to match('session_id')
        expect(response).to redirect_to('https://stripe.com/session')
      end
    end
  end

  describe 'GET /success' do
    let(:purchase) { create(:purchase, user:, item: course, status: :pending) }

    it 'updates the purchase status to succeeded and creates an enrollment' do
      get success_purchase_path(purchase)
      purchase.reload

      expect(purchase.status).to eq('succeeded')
      expect(response).to redirect_to(course_path(course))
      expect(flash[:notice]).to eq('Payment successful! You can now access the course.')
    end
  end

  describe 'GET /cancel' do
    let(:purchase) { create(:purchase, user:, item: course, status: :pending) }

    it 'updates the purchase status to canceled' do
      get cancel_purchase_path(purchase)
      purchase.reload

      expect(purchase.status).to eq('canceled')
      expect(response).to redirect_to(course_path(course))
      expect(flash[:alert]).to eq('Payment was canceled.')
    end
  end
end
