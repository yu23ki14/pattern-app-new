class ProjectMembersController < ApplicationController
  before_action :set_projects
  before_action :set_project_member, only: [:destroy]
  
  def create
    if @user.project_members.find_by(project_id: project_params[:project_id])
      redirect_to "/projects/" + project_params[:project_id], notice: '既に参加済みです。'
    else
      @project = ProjectMember.new(project_params)
      @project.save
      redirect_to "/projects/" + project_params[:project_id], notice: 'プロジェクトに参加しました。'
    end
  end
  
  def destroy
    @project_member.destroy
    redirect_to "/projects", notice: 'プロジェクトから抜けました。'
  end
  
  private
    def set_projects
      @projects = @user.projects
    end
    
    def set_project_member
      @project_member = ProjectMember.find(params[:id])
    end
    
    def project_params
      params.require(:project_member).permit(:project_id, :user_id)
    end
end