class Presentation::UserInterestsController < ApplicationController
  
  def index
    pattern_id = params[:pattern_id]
    if params[:type] == 'create'
      interest = Presentation::UserInterest.new(user_id: current_user.id, pattern_id: pattern_id)
      if interest.save
        respond_to do |format|
          format.json {
            render json: {result: "created"}, status: 200
          }
        end
      else
        respond_to do |format|
          format.json {
            render json: {result: "fail"}, status: 200
          }
        end
      end
    elsif params[:type] == 'delete'
      interest = Presentation::UserInterest.find_by(user_id: current_user.id, pattern_id: pattern_id)
      if interest.destroy
        respond_to do |format|
          format.json {
            render json: {result: "deleted"}, status: 200
          }
        end
      else
        respond_to do |format|
          format.json {
            render json: {result: "fail"}, status: 200
          }
        end
      end
    end
  end

end