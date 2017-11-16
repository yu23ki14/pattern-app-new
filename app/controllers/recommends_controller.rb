class RecommendsController < ApplicationController
  def index
    @phase1 = Phase1.all
  end
  
  def recommend
    @recommend = Recommend.create(user_id: current_user.id, phase_1: params[:phase_1_value])
  end
  
  def update
  end
  
  def phase2
    @phase_pre = Phase1.find(params[:phase_1_id])
    @phase = @phase_pre.phase2s
  end
  
  def phase3
    @phase_pre = Phase2.find(params[:phase_2_id])
    @phase = @phase_pre.phase3s
  end
  
  def phase4
    @phase_pre = Phase3.find(params[:phase_3_id])
    @phase = @phase_pre.phase4s
    if @phase_pre.context_id != nil
      @phase = Pattern.where(cat_code_24: 2)
    end
  end
  
  def recommend
    @phase_pre = Phase4.find(params[:phase_4_id])
    @phase = Pattern.where(cat_code_24: 2)
  end
  
  private
    def recommend_params
      params.require(:recommend).permit(:phase_1)
    end
  
end
