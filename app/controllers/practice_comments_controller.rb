class PracticeCommentsController < ApplicationController
  def create
    @practice_comment = PracticeComment.new(practice_comment_params)
    @practice_comment.save
    redirect_to practices_path, notice: "コメントしました。"
  end
  
  private
    def practice_comment_params
      params.require(:practice_comment).permit(:practice_id, :comment)
    end
end
