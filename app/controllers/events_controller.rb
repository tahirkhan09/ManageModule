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
        redirect_to events_index_path
    else
      #flash[:success] = 'All Fields Are Required.'
      #redirect_to :controller => "events", :action => "new"
      render 'new'

    end


  end

  def update
      @event = Event.find(params[:id])
      if @event.update(params_event)
        flash[:success] = 'Conference Has Been Updated Successfully'
        redirect_to events_index_path
      else
        render "edit"
      end
    end


  def destroy
    @event = Event.find(params[:id])
    if @event.delete
      redirect_to events_index_path
    end
  end

def edit
  @event = Event.find(params[:id])
end

  def add_compliance
    puts "000000000000000000000000000",params.inspect
    @event = Event.find(params[:event_id])
    @event.update_attributes(:compliance_notes => params[:event]["compliance_notes"])
    redirect_to events_index_path
  end




  private
  def params_event
    params[:event].permit(:event_id_dlp, :event_id_smi, :event_type , :rep_name , :speaker_name , :event_date , :event_month , :quarter , :event_city , :event_state , :speaker_city , :speaker_state , :speaker_travel_required)
  end
end
