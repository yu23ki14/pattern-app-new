class Presentation::PatternsController < ApplicationController
  #before_action :set_subdomain
  before_action :set_patterns
  
  def index
  end
  
  def show
    if params[:id].to_i > 33
      redirect_to presentation_patterns_path
    end
    @pattern = @patterns.find_by(pattern_no: params[:id])
    @posts = Presentation::Post.all.with_attached_thumb_image
  end
  
  private
    def set_patterns
      @patterns = Pattern.where(language_id: 3).order(:pattern_no)
    end
  
end