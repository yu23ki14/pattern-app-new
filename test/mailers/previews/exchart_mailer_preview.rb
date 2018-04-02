# Preview all emails at http://localhost:3000/rails/mailers/exchart_mailer
class ExchartMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/exchart_mailer/send_pdf
  def send_pdf
    ExchartMailer.send_pdf
  end

end
