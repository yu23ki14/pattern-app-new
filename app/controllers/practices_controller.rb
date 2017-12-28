class PracticesController < ApplicationController
  before_action :set_practices
  
  def index
    if user_signed_in?
      @now_practices = @practices.after(Date.today, field: :enddate).order("enddate")
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
      if @practices.where(language_id: practice_params[:language_id]).where(pattern_no: practice_params[:pattern_no]).find_by(done: nil) != nil
        redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: 'すでに登録されています。'
      else
        if practice_params[:limit] != "" && practice_params[:priority] != ""
          @practice_form = Practice.new(practice_params)
          @practice_form.save
          if params[:path] == "recommends"
            redirect_to recommends_path, notice: '追加しました！'
          else
            redirect_to "/patterns/" + practice_params[:language_id], notice: '追加しました！'
          end
        else
          redirect_to "/patterns/" + practice_params[:language_id] + "/" + practice_params[:pattern_no], alert: '期限と優先度は必須です。'
        end  
      end
    else
      redirect_to root_path
    end
  end
  
  def archive
    respond_to do |format|
      @practices = @practices.where.not(comment: nil).where(done: true).order("rate DESC")
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
  
  def patterndetail
    @language = Language.find(params[:language_id])
    @pattern = @language.patterns.find_by(pattern_no: params[:pattern_no])
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
      params.require(:practice).permit(:done, :comment, :rate)
    end
end
