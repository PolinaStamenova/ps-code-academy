class PurchasesController < ApplicationController
  before_action :set_course, only: [:create]

  def create
    # Exit if the user is already enrolled in the course
    if current_user.purchases.succeeded.exists?(item: @course)
      redirect_to course_path(@course), alert: 'You have already purchased this course.'

      return
    end

    purchase = current_user.purchases.create!(
      item: @course,
      user: current_user,
      quantity: 1,
      amount_in_cents: @course.price_in_cents,
      status: :pending
    )

    session = StripeCheckoutSessionService.new(
      purchase,
      success_url: success_purchase_url(purchase),
      cancel_url: cancel_purchase_url(purchase)
    ).call

    purchase.update!(stripe_session_id: session[:id])

    redirect_to session.url, allow_other_host: true
  end

  def success
    purchase = Purchase.find(params[:id])
    purchase.update!(status: :succeeded)
    Enrollment.create!(user: purchase.user, course: purchase.item, status: :not_started)

    redirect_to course_path(purchase.item), notice: 'Payment successful! You can now access the course.'
  end

  def cancel
    purchase = Purchase.find(params[:id])
    purchase.update!(status: :canceled)

    redirect_to course_path(purchase.item), alert: 'Payment was canceled.'
  end

  private

  def set_course
    @course = Course.active.find_by(id: purchase_params[:course_id])
  end

  def purchase_params
    params.require(:purchase).permit(:course_id)
  end
end
