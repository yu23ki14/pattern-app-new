class ExchartsController < ApplicationController
  def show
    @exchart = Exchart.find(params[:id])
    data1 = @exchart.data1
    gon.data1 = data1
    data2 = @exchart.data2
    gon.data2 = data2
    label = ExchartLabel.find_by(language_id: 1).label
    gon.label = label
    @patterns = Pattern.where(language_id: @exchart.language_id).order(:pattern_no)
    gon.patterns = @patterns
    current_pattern_no = JSON.parse(data1).select{|key,value| value > 0 }.keys()
    proximal_pattern_no = JSON.parse(data2).select{|key,value| value > 0 }.keys() - current_pattern_no
    @proximalpatterns = @patterns.where(pattern_no: proximal_pattern_no)
    @currentpatterns = @patterns.where(pattern_no: current_pattern_no)
  end
  
  def new
    @exchart = Exchart.new
    @patterns = Pattern.where(language_id: 1).where.not(pattern_no: 0).order(pattern_no: "DESC")
    @language = Language.find(1)
  end
  
  def create
    @exchart = Exchart.new(exchart_params)
    if @exchart.save
      redirect_to @exchart
    else
      render new
    end
  end
  
  private
    def exchart_params
      params.require(:exchart).permit(:user_id, :language_id, :data1, :data2)
    end
end
