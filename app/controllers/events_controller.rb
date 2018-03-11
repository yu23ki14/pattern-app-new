class EventsController < ApplicationController
  def index
    @events = @user.events
  end
  
  def new
    @event = Event.new
    @languages = Language.all
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
