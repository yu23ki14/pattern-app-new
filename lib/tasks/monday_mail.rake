namespace :monday_mail do
  desc "send monday mail"
  task :send => :environment do
    @projects = Project.where(monday_remind: true).includes(:project_practices)
    @projects.each do |p|
      @project_members = p.project_members
      @project_practices = p.project_practices.before(Date.today, field: :enddate).where(done: nil)
      @project_members.each do |pm|
        project_member = pm.user
        RegularDeliveryMailer.send_monday(project_member, @project_practices).deliver
      end
    end
  end
end