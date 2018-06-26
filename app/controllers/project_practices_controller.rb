class ProjectPracticesController < ApplicationController
  before_action :set_project_practice, only: [:did, :practice_comment, :addcomment, :update, :edit_practice]

  def create
    if user_signed_in?
      if project_practice_params[:project_id] = !nil
        @practices = ProjectPractice.where(project_id: project_practice_params[:project_id])
        if @practices.where(language_id: project_practice_params[:language_id]).where(pattern_no: project_practice_params[:pattern_no]).find_by(done: nil) != nil
          redirect_to "/patterns/" + project_practice_params[:language_id] + "/" + project_practice_params[:pattern_no], alert: 'すでに登録されています。'
        else
          if project_practice_params[:limit] != "" && project_practice_params[:priority] != ""
            @practice_form = ProjectPractice.new(project_practice_params)
            @practice_form.save
            redirect_to "/patterns/" + project_practice_params[:language_id], notice: '追加しました！'
          else
            redirect_to "/patterns/" + project_practice_params[:language_id] + "/" + project_practice_params[:pattern_no], alert: 'プロジェクト、期限、優先度は必須です。'
          end
        end
      else
        redirect_to "/patterns/" + project_practice_params[:language_id] + "/" + project_practice_params[:pattern_no], alert: 'プロジェクト、期限、優先度は必須です。'
      end
    else
      redirect_to root_path
    end
  end
  
  def did
    didcount = @practice[:did] + 1
    @practice.update(did: didcount, lastdate: Time.now)
  end
  
  def practice_comment
    @comments = @practice.project_practice_comments.order(created_at: :desc)
    @add_comment = ProjectPracticeComment.new
  end
  
  def addcomment
  end
  
  def update
    @practice.update(practice_done_params)
  end
  
  def edit_practice
  end
  
  private
    def set_project_practice
      @practice = ProjectPractice.find(params[:id])
    end
    
    def project_practice_params
      params.require(:project_practice).permit(:project_id, :language_id, :pattern_no, :limit, :priority, :action)
    end
    
    def practice_done_params
      params.require(:project_practice).permit(:done, :comment, :rate, :priority, :action)
    end
end
