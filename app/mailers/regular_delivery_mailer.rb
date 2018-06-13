class RegularDeliveryMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regular_delivery_mailer.send_monday.subject
  #
  def send_monday(project_member, project_practices, project)
    @project_practices = project_practices
    @project_member = project_member
    @project = project
    @url = "#{ENV["RAILS_ROOT"]}"
    mail to: @project_member.email,
         subject: "今週意識するパターン"

  end
end
