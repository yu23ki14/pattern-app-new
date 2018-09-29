class LearningStylesController < ApplicationController
  before_action :set_learning_style, only: [:edit, :show, :update, :destroy] 
  
  def index
    @temporary_saved_result = @user.learning_styles.where(finished: false)
    @learning_styles = @user.learning_styles.where(finished: true).order("created_at DESC")
  end
  
  def show
    if @learning_style.finished == false
      redirect_to learning_styles_path
    end
    @result = @learning_style.result
    gon.result = @result
  end
  
  def new
    @patterns = Pattern.where(language_id: 1..4).includes(:language).order(:language_id,:pattern_no)
    @learning_style = LearningStyle.new
  end
  
  def create
    @learning_style = LearningStyle.new(learning_style_params)
    if @learning_style.save
      if learning_style_params[:finished] == "true"
        redirect_to @learning_style
      else
        redirect_to learning_styles_path
      end
    else
      redirect_to new_learning_style_path
    end
  end
  
  def edit
    @patterns = Pattern.where(language_id: 1..4).includes(:language).order(:language_id,:pattern_no)
  end
  
  def update
    if @learning_style.update(learning_style_params)
      if learning_style_params[:finished] == "true"
        redirect_to @learning_style
      else
        redirect_to learning_styles_path
      end
    else
      redirect_to edit_learning_style_path(@learning_style)
    end
  end
  
  def destroy
    if @learning_style.delete
      redirect_to learning_styles_path
    else
      redirect_to learning_styles_path
    end
  end
  
  private
    def learning_style_params
      params.require(:learning_style).permit(:user_id, :result, :finished)
    end
    
    def set_learning_style
      @learning_style = LearningStyle.find(params[:id])
    end
end
