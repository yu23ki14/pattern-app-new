class Presentation::MypageController < ApplicationController
  before_action :set_patterns
  
  def index
    @stocks = Presentation::Post.with_attached_thumb_image
  end
  
  def posts
    @posts = Presentation::Post.where(user_id: current_user.id).with_attached_thumb_image
  end
  
  def patterns
  end
  
  private
    def set_patterns
      @patterns = Pattern.where(language_id: 3)
    end
  
end
