class Purchase < ApplicationRecord
  before_create :update_pending_purchases

  # Associations
  belongs_to :user
  belongs_to :item, class_name: 'Course'

  # Enums
  enum status: { pending: 0, failed: 1, canceled: 2, succeeded: 3 }

  # Scopes
  scope :pending, -> { where(status: :pending) }
  scope :succeeded, -> { where(status: :succeeded) }

  private

  # It could happed that a user is redirected to Stripe Checkout page
  # and then closes the browser or go back. In this case, a pending purchase will be created
  def update_pending_purchases
    return unless item.purchases.pending.any?

    item.purchases.pending.each do |pending_purchase|
      pending_purchase.update!(status: :failed)
    end
  end
end
