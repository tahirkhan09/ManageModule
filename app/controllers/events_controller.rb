class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def new
    #aaaaaaaaaa
    @event = Event.new()
  end

  def create
    puts "aaaaaaaaaaaaaaaaaaaaaaa",params.inspect
    @event = Event.new(params_event)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = 'Event has been created Successfully.'
      redirect_to :controller => "events", :action => "index"
    end

  end


  def destroy
    aaaaaaaaaaaaaa
    @event = Event.find(params[:format])
    if @event.delete
      redirect_to events_index_path
    end
  end

def edit
  @event = Event.find(params[:format])
end






  private
  def params_event
    params[:event].permit(:event_id_dlp, :event_id_smi, :event_type , :rep_name , :speaker_name , :event_date , :event_month , :quarter , :event_city , :event_state , :speaker_city , :speaker_state , :speaker_travel_required)
  end
end
