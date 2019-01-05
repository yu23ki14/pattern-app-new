class Presentation::PatternsController < ApplicationController
  #before_action :set_subdomain
  before_action :set_patterns
  
  def index
  end
  
  def show
    @pattern = @patterns.find(params[:id])
    @posts = @pattern.presentation_related_posts.page(params[:page]).per(8).with_attached_thumb_image.includes(:patterns)
    @popular_posts = @pattern.presentation_related_posts.limit(4).with_attached_thumb_image.includes(:patterns)
    if user_signed_in?
      @follow = Presentation::UserInterest.where(pattern_id: @pattern.id, user_id: current_user.id)
    end
    @followers = @pattern.presentation_followed_users
  end
  
  private
    def set_patterns
      @patterns = Pattern.where(language_id: 3).order(:pattern_no)
    end
  
end