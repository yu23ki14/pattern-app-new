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
    gon.patterns = @patterns
    ##以下jsで書き直したほうがよさげ
    current_pattern_no = JSON.parse(data1).select{|key,value| value > 0 }.keys()
    proximal_pattern_no = JSON.parse(data2).select{|key,value| value > 0 }.keys() - current_pattern_no
    @proximalpatterns = @patterns.where(pattern_no: proximal_pattern_no)
    @currentpatterns = @patterns.where(pattern_no: current_pattern_no)
    ##ここまで
    @practice_form = Practice.new
    @path = request.path
  end
  
  def new
    if params[:language_id].present? && params[:language_id] < "4"
      @language_id = params[:language_id]
    elsif params[:event].present?
      event_code = params[:event][:code]
      @event = Event.find_by(event_code: event_code)
      if !@event.present?
        redirect_to excharts_path
      else
        @language_id = @event.language_id
      end
    else
      redirect_to excharts_path
    end
    @exchart = Exchart.new
    @patterns = Pattern.where(language_id: @language_id).order(pattern_no: "DESC")
    @language = Language.find(@language_id)
  end
  
  def create
    @exchart = Exchart.new(exchart_params)
    if @exchart.save
      redirect_to @exchart
    else
      redirect_to new_exchart_path
    end
  end
  
  def event
  end
  
  def patterndetail
    @language = Language.find(params[:language_id])
    @pattern = @language.patterns.find_by(pattern_no: params[:pattern_no])
  end
  
  private
    def exchart_params
      params.require(:exchart).permit(:user_id, :language_id, :event_id, :data1, :data2)
    end
end
