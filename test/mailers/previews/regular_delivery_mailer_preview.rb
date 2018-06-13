# Preview all emails at http://localhost:3000/rails/mailers/regular_delivery_mailer
class RegularDeliveryMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/regular_delivery_mailer/send_monday
  def send_monday
    RegularDeliveryMailer.send_monday
  end

end
