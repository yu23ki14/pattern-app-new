class EventsController < ApplicationController
  
  before_action :set_event, only: [:graph, :show, :proximal, :current_after, :proximal_after]
  
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
  
  def graph
    @patterns = Pattern.where(language_id: @event.language_id).order("pattern_no")
    gon.default_label = @patterns.pluck(:pattern_name_ja)
    
    excharts = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
    gon.results = excharts.pluck(:data1)
    gon.proximal_results = excharts.pluck(:data2)
  end
  
  def show
    respond_to do |format|
      format.html {}
      format.csv {
        @results = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
        filename = @event.event_name
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def proximal
    respond_to do |format|
      format.html {}
      format.csv {
        @results = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
        filename = @event.event_name + "proximal"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def current_before
    respond_to do |format|
      format.html {}
      format.csv {
        results = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
        users = results.pluck(:user_id)
        results = Exchart.where(user_id: users).where("created_at > '2019-04-01'").order("created_at DESC").uniq{|result| result.user_id}
        users = results.pluck(:user_id)
        @results = Exchart.where(user_id: users).where("created_at < '2018-05-01'").order("created_at DESC").uniq{|result| result.user_id}
        filename = @event.event_name + "current_before"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def proximal_before
    respond_to do |format|
      format.html {}
      format.csv {
        results = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
        users = results.pluck(:user_id)
        results = Exchart.where(user_id: users).where("created_at > '2019-04-01'").order("created_at DESC").uniq{|result| result.user_id}
        users = results.pluck(:user_id)
        @results = Exchart.where(user_id: users).where("created_at < '2018-05-01'").order("created_at DESC").uniq{|result| result.user_id}
        filename = @event.event_name + "proximal_before"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def current_after
    respond_to do |format|
      format.html {}
      format.csv {
        results = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
        users = results.pluck(:user_id)
        @results = Exchart.where(user_id: users).where("created_at > '2019-04-01'").order("created_at DESC").uniq{|result| result.user_id}
        filename = @event.event_name + "current_after"
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      }
    end
  end
  
  def proximal_after
    respond_to do |format|
      format.html {}
      format.csv {
        results = @event.excharts.order("created_at DESC").uniq{|result| result.user_id}
        users = results.pluck(:user_id)
        @results = Exchart.where(user_id: users).where("created_at > '2019-04-01'").order("created_at DESC").uniq{|result| result.user_id}
        filename = @event.event_name + "proximal_after"
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
    
    def set_event
      @event = Event.find(params[:id])
    end
end
