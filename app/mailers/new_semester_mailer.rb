class NewSemesterMailer < ApplicationMailer
  def send_2018(users_address)
    I18n.locale = "ja"
    @users_address = users_address
    @url = "#{ENV["RAILS_ROOT"]}"
    mail(bcc: @users_address, subject: "井庭崇研究室PatternAppプロジェクトチームから新学期の学びデザインの提案")
  end
end
