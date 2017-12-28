class ProjectMembersController < ApplicationController
  def create
    @project = ProjectMember.new(project_params)
    @project.save
    redirect_to "/projects/" + project_params[:project_id], notice: 'プロジェクトに参加しました。'
  end
  
  private
    def project_params
      params.require(:project_member).permit(:project_id, :user_id)
    end
end
