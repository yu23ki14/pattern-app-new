class RegularDeliveryMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regular_delivery_mailer.send_monday.subject
  #
  def send_monday(project_member, project_practices)
    @project_practices = project_practices
    @project_member = project_member

    mail to: @project_member.email,
         subject: "パターン実践してますか？"
    
    #RegularDeliveryMailer.send_monday(current_user, @practices.where(done: nil)).deliver
  end
end
