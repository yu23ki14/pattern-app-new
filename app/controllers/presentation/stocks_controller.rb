class Presentation::StocksController < ApplicationController
  
  def index
    post_id = params[:post_id]
    if params[:type] == 'create'
      stock = Presentation::Stock.new(user_id: current_user.id, presentation_post_id: post_id)
      if stock.save
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
      stock = Presentation::Stock.find_by(user_id: current_user.id, presentation_post_id: post_id)
      if stock.destroy
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