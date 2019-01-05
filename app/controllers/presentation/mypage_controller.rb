class Presentation::MypageController < ApplicationController
  before_action :set_patterns
  
  def index
    @stocks = @user.presentation_stocked_posts.page(params[:page]).per(15).with_attached_thumb_image.includes(:patterns)
  end
  
  def posts
    @posts = @user.presentation_posts.page(params[:page]).per(15).with_attached_thumb_image.includes(:patterns).order(created_at: "DESC")
  end
  
  def patterns
  end
  
  private
    def set_patterns
      @patterns = Pattern.where(language_id: 3).order(:pattern_no)
    end
  
end
