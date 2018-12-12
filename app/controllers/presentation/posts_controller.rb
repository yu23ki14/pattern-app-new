class Presentation::PostsController < ApplicationController
  #before_action :set_subdomain
  
  def show
    @post = Presentation::Post.find(params[:id])
    related_pattern_no = JSON.parse(@post.pattern)
    @related_patterns = Pattern.where(language_id: 3).where(pattern_no: related_pattern_no)
    @comment = Presentation::PostComment.new
  end
  
  def new
    @post = Presentation::Post.new
    @patterns = Pattern.where(language_id: 3).order(:pattern_no)
  end
  
  def  create
    @post = Presentation::Post.new(presentation_post_params)
    if @post.save
      redirect_to @post
    else
      redirect_to new_presentation_post_path
    end
  end
  
  def edit
    @post = Presentation::Post.find(params[:id])
    gon.post_content = @post.content
    @patterns = Pattern.where(language_id: 3).order(:pattern_no)
  end
  
  def  update
    @post = Presentation::Post.find(params[:id])
    if @post.update(presentation_post_params)
      redirect_to @post
    else
      redirect_to new_presentation_post_path
    end
  end
  
  def get_web_reference
    respond_to do |format|
      format.json {
        render json: {test_data: "てすと"}, status: 200
      }
    end
  end
  
  private
    def presentation_post_params
      params.require(:presentation_post).permit(:user_id, :title, :reference_store, :reference, :link, :content, :pattern, :thumb_image)
    end
    
    def presentation_post_comment_params
      params.require(:presentation_post_comment).permit(:user_id, :comment, presentation_post_id)
    end
end
