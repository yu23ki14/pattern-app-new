class ExchartMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.exchart_mailer.send_pdf.subject
  #
  def send_pdf(user, pdf)
    
    attachments['exchart.pdf'] = pdf if pdf.present?
    
    mail to: user.email,
          subject: '経験チャート送付'
  end
end
