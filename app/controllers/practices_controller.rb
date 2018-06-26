class PracticesController < ApplicationController
  before_action :set_practices
  before_action :set_practice, only: [:did, :practice_comment, :addcomment, :update, :edit_practice]
  
  def index
    if user_signed_in?
      respond_to do |format|
        @now_practices = @practices.includes(:practice_comments).after(Date.today, field: :enddate).order("enddate")
        @ended_practices = @practices.before(Date.today, field: :enddate)
        format.html
        format.js
      end
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
        redirect_to Rails.application.routes.recognize_path(request.referer), alert: 'すでに登録されています。'
      else
        if practice_params[:limit] != "" && practice_params[:priority] != ""
          @practice_form = Practice.new(practice_params)
          if @practice_form.save
            if params[:path] == "recommends"
              redirect_to recommends_path, notice: '追加しました！'
            elsif params[:path].include?("excharts")
              redirect_to params[:path], notice: '追加しました！'
            else
              redirect_to "/patterns/" + practice_params[:language_id], notice: '追加しました！'
            end
          else
            redirect_to projects_path, alert: '追加できませんでした。'
          end
        else
          redirect_to Rails.application.routes.recognize_path(request.referer), alert: '期限と優先度は必須です。'
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
  
  def edit_practice
  end
  
  def did
    if @practice.lastdate+ 43200 < Time.now
      didcount = @practice[:did] + 1
      @practice.update(did: didcount, lastdate: Time.now)
    end
  end
  
  def addcomment
  end
  
  def patterndetail
    @language = Language.find(params[:language_id])
    @pattern = @language.patterns.find_by(pattern_no: params[:pattern_no])
  end
  
  def practice_comment
    @comments = @practice.practice_comments.order(created_at: :desc)
    @add_comment = PracticeComment.new
  end
  
  def update
    @practice.update(practice_done_params)
  end
  
  private
    def set_practices
      if user_signed_in?
        @practices = @user.practices
      end
    end
    
    def set_practice
      @practice = Practice.find(params[:id])
    end
    
    def practice_params
      params.require(:practice).permit(:user_id, :language_id, :pattern_no, :limit, :priority, :action)
    end
    def practice_done_params
      params.require(:practice).permit(:done, :comment, :rate, :priority, :action)
    end
end
