class StripeCheckoutSessionService
  def initialize(purchase, success_url:, cancel_url:)
    @purchase = purchase
    @success_url = success_url
    @cancel_url = cancel_url
  end

  def call
    Stripe::Checkout::Session.create(
      client_reference_id: @purchase.user.id,
      # TODO: Ask user to use account email for payments or another email
      customer_email: @purchase.user.email || 'john@test.com',
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: "#{@purchase.item.name} - by #{@purchase.user.full_name}"
          },
          unit_amount: @purchase.amount_in_cents # Price in cents
        },
        quantity: @purchase.quantity
      }],
      mode: 'payment',
      success_url: @success_url,
      cancel_url: @cancel_url,
      metadata: {
        purchase_id: @purchase.id
      }
    )
  end
end
