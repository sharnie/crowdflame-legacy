class PaymentController < ApplicationController
  def index
    @payment_email = current_user.payment.email if current_user.payment
  end

  def new
    @payment = Payment.new
  end

  def create
    payment = current_user.create_payment(payment_params)

    if payment.save
      flash[:notice] = "Your payment has been updated!"
    end
  end

private

  def payment_params
    params.require(:payment).permit(:email)
  end
end
