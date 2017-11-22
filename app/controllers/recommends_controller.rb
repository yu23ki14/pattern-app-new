class RecommendsController < ApplicationController
  before_action :set_recommend, only: [:index, :phase2, :phase3, :phase4, :create, :update, :recommend, :cat_code]
  before_action :set_result, only: [:index]
  
  def index
    @phase1 = Phase1.all
  end
  
  def create
    respond_to do |format|
      @recommend = Recommend.create(recommend_params)
      format.js
    end
  end
  
  def update
    respond_to do |format|
      @recommend = @recommend.update(recommend_params)
      format.html { redirect_to recommends_path}
      format.js
    end
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
      @phase = Pattern.where(cat_code: @phase_pre.context_id)
    end
  end
  
  def recommend
    @phase_pre = Phase4.find(params[:phase_4_id])
    @phase = Pattern.where(cat_code: @phase_pre.context_id)
  end
  
  def cat_code
    @recommend.update(cat_code: params[:cat_code])
  end
  
  private
    def recommend_params
      params.require(:recommend).permit(:user_id, :phase_1, :phase_2, :phase_3, :phase_4, :cat_code, :drop)
    end
    
    def set_recommend
      @recommend = @user.recommends.where(drop: false).last
      if @recommend == nil
        Recommend.create(:user_id => current_user.id)
      end
    end
    
    def set_result
      if @recommend != nil
        if @recommend.cat_code != nil
          @result = Pattern.where(cat_code: @recommend.cat_code)
        end
      end
    end
    
end
