class PaymentsController < ApplicationController
  def create
    stripe_id = current_user.stripe_id
    payment = current_user.payments.create(amount: params[:amount])
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end
end
