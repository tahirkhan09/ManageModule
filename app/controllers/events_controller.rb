class EventsController < ApplicationController
  before_action :authenticate_user!
  require 'csv'
  def index
    @events = Event.all
  end

  def new
    #aaaaaaaaaa
    @event = Event.new()
  end

  def create
    @event = Event.new(params_event)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = 'Event has been Successfully created.'
      redirect_to events_index_path
    else
      #flash[:success] = 'All Fields Are Required.'
      #redirect_to :controller => "events", :action => "new"
      render 'new'

    end


  end

  #def update
  #    @event = Event.find(params[:id])
  #    if @event.update(params_event)
  #      flash[:success] = 'Conference Has Been Updated Successfully'
  #      redirect_to events_index_path
  #    else
  #      render "edit"
  #    end
  #  end


  #def destroy
  #  @event = Event.find(params[:id])
  #  if @event.delete
  #    redirect_to events_index_path
  #  end
  #end

  #def edit
  #  @event = Event.find(params[:id])
  #end
  def check_lock_event
    @event = Event.find(params[:event_id])
    if @event.is_lock == false
      @event.update_attributes(:is_lock => true)
      flash[:success] = 'Event Has Beek Successfully Locked'
    elsif @event.is_lock == true
      @event.update_attributes(:is_lock => false)
      flash[:success] = 'Event Has Been Successfully Un-locked'
    end
    render :text => "ok"
  end


  def add_compliance
    @event = Event.find(params[:event_id])
    @event.update_attributes(:compliance_notes => params[:event]["compliance_notes"])
    redirect_to events_index_path
  end


  def filter_events
    start_date = Time.strptime(params[:start_date], '%m/%d/%Y')
    start_date = start_date.strftime("%Y-%m-%d").to_date
    end_date = Time.strptime(params[:end_date], '%m/%d/%Y')
    end_date = end_date.strftime("%Y-%m-%d").to_date
    all_events = []
    @events = Event.all
    @events.each do |event|
      time1 = Time.strptime(event.event_date, '%m/%d/%Y').to_date
      if (time1 <= end_date && time1 >= start_date)
        all_events << event
      end
    end
     @events = all_events
    #@events = Event.where("STR_TO_DATE(event_date, '%m/%d/%Y') BETWEEN '#{start_date}'  AND '#{end_date}'")
    render :partial => "events/event_list"
  end

  #def filter_events
  #start_date = Time.strptime(params[:start_date], '%m/%d/%Y')
  #start_date = start_date.strftime("%Y-%m-%d")
  #end_date = Time.strptime(params[:end_date], '%m/%d/%Y')
  #end_date = end_date.strftime("%Y-%m-%d")
  ##@events = ActiveRecord::Base.connection.execute("SELECT * FROM events WHERE  STR_TO_DATE(event_date, '%m/%d/%Y') BETWEEN '#{start_date}'  AND '#{end_date}'")
  #@events = Event.where("STR_TO_DATE(event_date, '%m/%d/%Y') BETWEEN '#{start_date}'  AND '#{end_date}'")
  #render :partial => "events/event_list"
  #end

  def download_csv
    @events = Event.all
    unless @events.blank?
      header = "Event Id Dlp,Event Type,Rep Name,Speaker Name,Event City,Event State,Speaker City,Speaker State,Total Attendees,Final Gurantee,Final Gurantee Count,F&B Cost,NS HCP #,NS HCP $,Net Meal Cost, Meal Cost/Attendee"
      file = "ManageModule.csv"
      File.open(file, "w") do |csv|
        csv << header
        csv << "\n"
        @events.each do |event|
          #........................................................
          @sign_in_sheet = SignInSheet.where(:event_id => event.id).first
          if @sign_in_sheet.present?
            total_attendee = @sign_in_sheet.non_profiled_attendee.to_i + @sign_in_sheet.prescribing_attendee.to_i + @sign_in_sheet.client_employee_attendee.to_i + @sign_in_sheet.speaker.to_i
          end
          total_fb_cost = event.expenses.where("expense_type =? or expense_type =? or expense_type =?", 'Meals (Deposit)', 'Meals', 'Meals_2')
          sum_of_total_fb_cost = "0"
          total_fb_cost.each do |a|
            sum_of_total_fb_cost = sum_of_total_fb_cost.to_f + a.amount.to_f
          end
          ns_hcp_1 = event.final_gurantee_count.to_i - total_attendee.to_i
          if ns_hcp_1 < 0
            ns_hcp_1 = 0
          end
          ns_hcp_2 = (sum_of_total_fb_cost.to_f/event.final_gurantee_count.to_f).to_f*ns_hcp_1 unless event.final_gurantee_count.blank?
          net_meal_cost = (sum_of_total_fb_cost.to_f - ns_hcp_2.to_f) unless ns_hcp_2.to_s == "NaN" unless ns_hcp_2.blank?
          meal_cost_per_attendee = (net_meal_cost.to_f/total_attendee.to_f).to_f unless net_meal_cost.to_s == "NaN"
          #........................................................
          csv << event.event_id_dlp
          csv << ","
          csv << event.event_type
          csv << ","
          csv << event.rep_name
          csv << ","
          csv << event.speaker_name
          csv << ","
          csv << event.event_city
          csv << ","
          csv << event.event_state
          csv << ","
          csv << event.speaker_city
          csv << ","
          csv << event.speaker_state
          csv << ","
          csv << total_attendee
          csv << ","
          csv << event.final_gurantee
          csv << ","
          csv << event.final_gurantee_count
          csv << ","
          csv << sum_of_total_fb_cost
          csv << ","
          csv << ns_hcp_1
          csv << ","
          csv << ns_hcp_2
          csv << ","
          csv << net_meal_cost
          csv << ","
          csv << meal_cost_per_attendee
          csv << "\n"
        end
      end
      send_file(file)
    end
  end

  private
  def params_event
    params[:event].permit(:event_id_dlp, :event_id_smi, :event_type, :rep_name, :speaker_name, :event_date, :event_month, :quarter, :event_city, :event_state, :speaker_city, :speaker_state, :speaker_travel_required)
  end
end
