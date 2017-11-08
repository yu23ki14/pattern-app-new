class PracticesController < ApplicationController
  before_action :set_practices
  
  def index
    if user_signed_in?
      @now_practices = @practices.after(Date.today, field: :enddate)
      @ended_practices = @practices.before(Date.today, field: :enddate)
    end
  end
  
  def complete
    @practices = @practices.before(Date.today, field: :enddate)
  end
  
  def create
    if user_signed_in?
      if practice_params[:limit] != ""
        @practice_form = Practice.new(practice_params)
        @practice_form.save
        #@practice = Practice.create(practice_params)
        redirect_to "/patterns/" + practice_params[:language_id], notice: '追加しました！'
      else
        redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: '期限を入力してください。'
      end  
    else
      redirect_to root_path
    end
  end
  
  def did
    @practice = Practice.find(params[:id])
    didcount = @practice[:did] + 1
    @practice.update(did: didcount, lastdate: Time.now)
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
    def set_practices
      if user_signed_in?
        @practices = @user.practices
      end
    end
    def practice_params
      params.require(:practice).permit(:user_id, :language_id, :pattern_no, :limit, :priority)
    end
end
