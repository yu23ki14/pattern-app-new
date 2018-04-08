class EventsController < ApplicationController
  def index
    if Rails.env == 'production'
      if current_user.id == 2 || current_user.id == 5 || current_user.id == 183
        @events = Event.all
      else
        @events = []
      end
    else
      @events = @user.events
    end
  end
  
  def new
    @event = Event.new
    @languages = Language.all
  end
  
  def show
    respond_to do |format|
      format.html {}
      format.csv {
        @event = Event.find(params[:id])
        @results = @event.excharts
        filename = @event.event_name
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def proximal
    respond_to do |format|
      format.html {}
      format.csv {
        @event = Event.find(params[:id])
        @results = @event.excharts
        filename = @event.event_name + "proximal"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      redirect_to new_event_path
    end
  end
  
  private
    def event_params
      params.require(:event).permit(:user_id, :event_name, :language_id, :event_code, :other_details, :limit)
    end
end
