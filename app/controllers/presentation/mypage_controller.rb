class Presentation::MypageController < ApplicationController
  before_action :set_patterns
  
  def index
    @stocks = @user.presentation_stocked_posts.publish.page(params[:page]).per(15).with_attached_thumb_image.includes(:patterns)
  end
  
  def posts
    if params[:state] == "draft"
      @posts = @user.presentation_posts.draft.page(params[:page]).per(15).with_attached_thumb_image.includes(:patterns).order(created_at: "DESC")
    else
      @posts = @user.presentation_posts.publish.page(params[:page]).per(15).with_attached_thumb_image.includes(:patterns).order(created_at: "DESC")
    end
  end
  
  def patterns
  end
  
  private
    def set_patterns
      @patterns = Pattern.where(language_id: 3).order(:pattern_no)
    end
  
end
