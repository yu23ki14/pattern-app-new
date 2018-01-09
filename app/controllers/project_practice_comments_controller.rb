class ProjectPracticeCommentsController < ApplicationController
  def create
    @practice_comment = ProjectPracticeComment.new(practice_comment_params)
    @practice_comment.save
    redirect_to "/projects/" + @practice_comment.project_practice.project.id.to_s, notice: "コメントしました。"
  end
  
  private
    def practice_comment_params
      params.require(:project_practice_comment).permit(:user_id, :project_practice_id, :comment)
    end
end
