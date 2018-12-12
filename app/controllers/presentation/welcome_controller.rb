class Presentation::WelcomeController < ApplicationController
  #before_action :set_subdomain
  
  def index
    @posts = Presentation::Post.with_attached_thumb_image
    @patterns = Pattern.where(language_id: 3)
  end
  
end