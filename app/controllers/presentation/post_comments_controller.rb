class Presentation::PostCommentsController < ApplicationController
  
  def create
    @comment = Presentation::PostComment.new(presentation_post_comment_params)
    if @comment.save
      respond_to do |format|
        format.json {
          render json: {result: "success"}, status: 200
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
  
end