class Presentation::PostCommentsController < ApplicationController
  
  def create
    @comment = Presentation::PostComment.new(presentation_post_comment_params)
    input_patams = params[:presentation_post_comment]
    comment = input_patams[:comment]
    user_name = current_user.name
    if @comment.save
      respond_to do |format|
        format.json {
          render json: {result: "success", comment: comment, user_name: user_name}, status: 200
        }
      end
    else
      respond_to do |format|
        format.json {
          render json: {result: "fail"}, status: 200
        }
      end
    end
  end
  
  private
    def presentation_post_comment_params
      params.require(:presentation_post_comment).permit(:user_id, :comment, :presentation_post_id)
    end
end