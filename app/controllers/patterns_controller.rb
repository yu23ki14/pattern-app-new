class PatternsController < ApplicationController
  before_action :set_pattern, only: [:edit, :update, :destroy]

  # GET /patterns
  # GET /patterns.json
  def index
    @patterns = Pattern.all
  end

  def show
    @patterns = Pattern.where(lg_code: params[:lg_code])
    @language = Language.find_by(lg_code: params[:lg_code])
  end
  
  def details
    @language = Language.find_by(lg_code: params[:lg_code])
    @pattern = Pattern.where(lg_code: params[:lg_code]).find_by(pattern_no: params[:pattern_no])
    @favorite = Favorite.where(user_id_id: params[:user_id]).where(lg_code_id: params[:lg_code]).find_by(pattern_no_id: params[:pattern_no])
  end
  
  def fav
    @fav_serch = Favorite.where(user_id_id: params[:user_id]).where(lg_code_id: params[:lg_code]).find_by(pattern_no_id: params[:pattern_no])
    if @fav_serch == nil
      @favorite = Favorite.create(user_id_id: params[:user_id], lg_code_id: params[:lg_code], pattern_no_id: params[:pattern_no])
    else
      @fav_serch.fav = !@fav_serch.fav
      @fav_serch.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pattern
      @pattern = Pattern.find(params[:id])
    end
end
