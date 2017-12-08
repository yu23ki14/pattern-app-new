class PatternsController < ApplicationController
  before_action :set_pattern, only: [:edit, :update, :destroy]
  before_action :set_favorites, only: [:show, :details, :fav]
  before_action :set_practices, only: [:details]

  # GET /patterns
  # GET /patterns.json
  def index
    @patterns = Pattern.all
  end

  def show
    @language = Language.find(params[:language_id])
    @patterns = @language.patterns
  end
  
  def details
    @language = Language.find(params[:language_id])
    @pattern = @language.patterns.find_by(pattern_no: params[:pattern_no])
    if user_signed_in?
      @favorite = @favorites.find_by(pattern_no: params[:pattern_no])
      @practice = @practices.where(done: nil).find_by(pattern_no: params[:pattern_no])
      @practice_form = Practice.new
    end
    @related_patterns = Pattern.where(cat_code_24: @pattern[:cat_code_24]).order("RANDOM()").limit(2)
  end
  
  def fav
    if user_signed_in?
      @favorite = @favorites.find_by(pattern_no: params[:pattern_no])
      if @favorite == nil
        @favorite = Favorite.create(user_id: current_user.id, language_id: params[:language_id], pattern_no: params[:pattern_no])
      else
        @favorite.destroy
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pattern
      @pattern = Pattern.find(params[:id])
    end
    
    def set_favorites
      if user_signed_in?
        @favorites = @user.favorites
        @favorites = @favorites.where(language_id: params[:language_id])
      end
    end
    
    def set_practices
      if user_signed_in?
        @practices = @user.practices
        @practices = @practices.where(language_id: params[:language_id])
      end
    end
end
