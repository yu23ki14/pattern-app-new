class ExchartsController < ApplicationController
  def index
    @results = @user.excharts.includes(:language, :event).order(created_at: "DESC")
  end
  
  def show
    @exchart = Exchart.find(params[:id])
    data1 = @exchart.data1
    gon.data1 = data1
    data2 = @exchart.data2
    gon.data2 = data2
    label = ExchartLabel.find_by(language_id: @exchart.language_id).label
    gon.label = label
    @language = @exchart.language
    @patterns = Pattern.where(language_id: @exchart.language_id).order(:pattern_no)
    gon.patterns = @patterns.order(:axis_no)
    ##以下jsで書き直したほうがよさげ
    current_pattern_no = JSON.parse(data1).select{|key,value| value > 0 }.keys()
    proximal_pattern_no = JSON.parse(data2).select{|key,value| value > 0 }.keys() - current_pattern_no
    @proximalpatterns = @patterns.where(pattern_no: proximal_pattern_no)
    @currentpatterns = @patterns.where(pattern_no: current_pattern_no)
    ##ここまで
    @practice_form = Practice.new
    @path = request.path
  end
  
  def pdf
    respond_to do |format|
      format.pdf do
        set_chart
        render pdf: 'dialogue_workshop_sheet',
               encording: 'UTF-8',
               layout: 'application_pdf.html',
               orientation: 'Landscape',
               show_as_html: params[:debug].present?
      end
    end
  end
  
  def send_pdf
    respond_to do |format|
      format.pdf do
        set_chart
        pdf = render_to_string pdf: "dialogue_workshop_sheet.pdf",
              encoding: "UTF-8",
              orientation: 'Landscape',
              layout: "application_pdf.html",
              template: "excharts/pdf.pdf.slim"
        ExchartMailer.send_pdf(current_user, pdf).deliver
        redirect_to excharts_path, notice: 'メールでPDFを送りました。'
      end
    end
  end
  
  def new
    if params[:language_id].present? && params[:language_id] < "4"
      @language_id = params[:language_id]
      @exchart = Exchart.new
      @patterns = Pattern.where(language_id: @language_id).order(pattern_no: "DESC").order(:axis_no)
      @language = Language.find(@language_id)
    elsif params[:event].present?
      event_code = params[:event][:code]
      @event = Event.find_by(event_code: event_code)
      if !@event.present?
        redirect_to excharts_path
      else
        @language_id = @event.language_id
        @exchart = Exchart.new
        @patterns = Pattern.where(language_id: @language_id).order(pattern_no: "DESC")
        @language = Language.find(@language_id)
      end
    else
      redirect_to excharts_path
    end
    
  end
  
  def create
    @exchart = Exchart.new(exchart_params)
    patterns_no = Pattern.where(language_id: exchart_params[:language_id]).length
    if exchart_params[:data1] != ""
      if JSON.parse(exchart_params[:data1]).length == patterns_no
        if @exchart.save
          redirect_to @exchart
        else
          redirect_to new_exchart_path
        end
      else
        redirect_to new_exchart_path, alert: "データに誤りがあります。"
      end
    else
      redirect_to new_exchart_path, alert: "データに誤りがあります。"
    end
  end
  
  def event
  end
  
  def patterndetail
    @language = Language.find(params[:language_id])
    @pattern = @language.patterns.find_by(pattern_no: params[:pattern_no])
  end
  
  def compare
    @lg = params[:language_id]
    
    if @lg != nil
      @language = Language.find(params[:language_id])
      @results = @user.excharts.where(language_id: @lg).order(created_at: "DESC")
    end
  end
  
  def compare_result
    if !params[:chart_id_1]
      redirect_to practices_path
    else
      @exchart_1 = Exchart.find(params[:chart_id_1])
      @exchart_2 = Exchart.find(params[:chart_id_2])
      
      if @exchart_1.created_at > @exchart_2.created_at
        temp = @exchart_1
        @exchart_1 = @exchart_2
        @exchart_2 = temp
      end
      
      data1 = @exchart_1.data1
      gon.data1 = data1
      data2 = @exchart_2.data1
      gon.data2 = data2
      label = ExchartLabel.find_by(language_id: @exchart_1.language_id).label
      gon.label = label
      @language = @exchart_1.language
      @patterns = Pattern.where(language_id: @exchart_1.language_id).order(:pattern_no)
      gon.patterns = @patterns.order(:axis_no)
      ##以下jsで書き直したほうがよさげ
      prev_pattern_no = JSON.parse(data1).select{|key,value| value > 0 }.keys()
      new_pattern_no = JSON.parse(data2).select{|key,value| value > 0 }.keys()
      all_pattern_no = prev_pattern_no + new_pattern_no
      @currentpatterns = @patterns.where(pattern_no: new_pattern_no)
      @allpatterns = @patterns.where(pattern_no: all_pattern_no)
      ##ここまで
      @practice_form = Practice.new
      @path = request.path
    end
  end
  
  private
    def exchart_params
      params.require(:exchart).permit(:user_id, :language_id, :event_id, :data1, :data2)
    end
    
    def set_chart
      @chart = params[:chart][:image]
      @exchart = Exchart.find(params[:id])
      data1 = @exchart.data1
      data2 = @exchart.data2
      @language = @exchart.language
      #@core_pattern = Pattern.where(language_id: @exchart.language_id).find_by(pattern_no: 0)
      #@patterns = Pattern.where(language_id: @exchart.language_id).where.not(pattern_no: 0).order(:pattern_no)
      @patterns = Pattern.where(language_id: @exchart.language_id).order(:pattern_no)
      @current_pattern_no = JSON.parse(data1).select{|key,value| value > 0 }.keys()
      @proximal_pattern_no = JSON.parse(data2).select{|key,value| value > 0 }.keys() - @current_pattern_no
    end
end
