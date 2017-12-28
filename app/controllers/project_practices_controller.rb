class ProjectPracticesController < ApplicationController

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
  
  private
    def project_practice_params
      params.require(:project_practice).permit(:project_id, :language_id, :pattern_no, :limit, :priority)
    end
end
