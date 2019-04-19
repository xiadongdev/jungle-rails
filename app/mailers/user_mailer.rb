class UserMailer < ApplicationMailer
  default from: 'orderConfirmation@jungle.com'
  def order_confirmation(order)
    @order = order
    mail(to: 'dongxiapp@gmail.com', subject: "Your Jungle.com Order Was Received.")
  end
end
