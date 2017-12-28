class ProjectsController < ApplicationController
  before_action :set_practices, only: [:show, :complete, :archive]
  
  def index
    @projects = @user.projects
  end
  
  def show
    @now_practices = @practices.after(Date.today, field: :enddate).order("enddate")
  end
  
  def complete
    respond_to do |format|
      @practices = @practices.before(Date.today, field: :enddate).where(done: nil)
      @practice = Practice.new
      format.js
    end
  end
  
  def archive
    respond_to do |format|
      @practices = @practices.where.not(comment: nil).where(done: true).order("rate DESC")
      format.js
    end
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    if project_params[:project_name] != "" || project_params[:project_id] != ""
      @project.save
      @project_master = ProjectMember.create(:user_id => current_user.id, :project_id => @project.id)
      redirect_to @project, notice: 'プロジェクトを追加しました。'
    else
      redirect_to new_project_path, alert: 'プロジェクト名とプロジェクトIDを入力してください。'
    end
  end
  
  def join
    @q = Project.ransack(params[:q])
    @project = @q.result(distinct: true)
  end
  
  def search
    @q = Project.ransack(params[:q])
    @project = @q.result(distinct: true)
    @join_project = ProjectMember.new
  end
  
  def edit
  end

  def destroy
  end

  private
    def set_projects
      @project = Project.find(params[:id])
    end
    
    def set_practices
      @project = Project.find(params[:id])
      @practices = @project.project_practices
    end
    
    def project_params
      params.require(:project).permit(:project_name, :project_summary, :project_id, :project_color)
    end
end
