class PracticesController < ApplicationController
  before_action :set_practices
  
  def index
    if user_signed_in?
      @now_practices = @practices.after(Date.today, field: :enddate)
      @ended_practices = @practices.before(Date.today, field: :enddate)
    end
  end
  
  def complete
    respond_to do |format|
      @practices = @practices.before(Date.today, field: :enddate).where(done: nil)
      @practice = Practice.new
      format.js
    end
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
  
  def archive
    respond_to do |format|
      @practices = @practices.where(done: true)
      @practice = Practice.new
      format.js
    end
  end
  
  def did
    @practice = Practice.find(params[:id])
    didcount = @practice[:did] + 1
    @practice.update(did: didcount, lastdate: Time.now)
  end
  
  def addcomment
    @practice = Practice.find(params[:id])
  end
  
  def update
    @practice = Practice.find(params[:id])
    @practice.update(practice_done_params)
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
    def practice_done_params
      params.require(:practice).permit(:done, :comment)
    end
end
