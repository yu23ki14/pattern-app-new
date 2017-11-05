class PracticesController < ApplicationController
  before_action :set_practices
  
  def index
    @now_practices = @practices.after(Date.today, field: :enddate)
    @ended_practices = @practices.before(Date.today, field: :enddate)
  end
  
  def complete
    @practices = @practices.before(Date.today, field: :enddate)
  end
  
  def create
    if user_signed_in?
      if practice_params[:limit] != ""
        if practice_params[:limit] == "7" && practice_params[:frequency] == "week"
          redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: '期限は頻度より長くしてください。'
        elsif practice_params[:limit] == "7" && practice_params[:frequency] == "month"
          redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: '期限は頻度より長くしてください。'
        elsif practice_params[:limit] == "30" && practice_params[:frequency] == "month"
          redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: '期限は頻度より長くしてください。'
        else
          @practice_form = Practice.new(practice_params)
          @practice_form.save
          #@practice = Practice.create(practice_params)
          redirect_to "/patterns/" + practice_params[:language_id], notice: '追加しました！'
        end
      else
        redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: '期限を入力してください。'
      end  
    else
      redirect_to root_path
    end
  end
  
  private
    def set_practices
      if user_signed_in?
        @practices = @user.practices
      end
    end
    def practice_params
      params.require(:practice).permit(:user_id, :language_id, :pattern_no, :limit, :frequency)
    end
end
