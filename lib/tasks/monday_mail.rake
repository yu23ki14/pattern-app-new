namespace :monday_mail do
  desc "send monday mail"
  task :send => :environment do
    @projects = Project.where(monday_remind: true).includes(:project_practices)
    @projects.each do |project|
      @project = project
      @project_members = project.project_members
      @project_practices = project.project_practices.after(Date.today, field: :enddate).where(done: nil)
      @project_members.each do |pm|
        project_member = pm.user
        RegularDeliveryMailer.send_monday(project_member, @project_practices, @project).deliver
      end
    end
  end
end