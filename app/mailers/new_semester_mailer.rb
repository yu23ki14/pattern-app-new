class NewSemesterMailer < ApplicationMailer
  def send_2018(users_address)
    I18n.locale = "ja"
    @users_address = users_address
    @url = "#{ENV["RAILS_ROOT"]}"
    mail(bcc: @users_address, subject: "１年経ってどれだけ学びの経験が増えたかをチェックしてみよう【ラーニング・パターンによる自己診断】")
  end
end
