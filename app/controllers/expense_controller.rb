class ExpenseController < ApplicationController
  def index
    @event = Event.new
  end

  def manage_event
    @event = Event.new
  end

  def add_event_details
    puts "///////////////////////////////////////",params.inspect
    #puts "111111111111111111111111111111111111111",params[:event_id]
    puts "222222222222222222222222222222222222222",params[:event]
    #puts "333333333333333333333333333333333333333",params[:event]["av_notes"]
    #puts "444444444444444444444444444444444444444",params[:event][:expenses_attributes]
    #puts "333333333333333333333333333333333333333",params[:event][:expenses_attributes]


    @event = Event.find(params[:event_id])
    if @event.update_attributes(event_params)
      #kkkkkk
    else
     puts "CCC", @event.errors.inspect
    end

    #@expense = Expense.new()
    #puts "----------------------------------",@expense.inspect
    #params[:event][:expenses_attributes].each do |a|
    #  puts "000000000000000000000000000000000",a[1].inspect
    #  @expense = Expense.new(:expense_type => a[1]["expense_type"],:amount => a[1]["amount"],:value_transfer_date => params[:event][:expense]["value_transfer_date"].to_s ,:payment_mode => params[:event][:expense]["payment_mode"],:notes => params[:event][:expense]["notes"],:event_id => params[:event_id])
    #end
      redirect_to :controller => "events",:action => "index"
  end

  private
  def event_params
      params.require(:event).permit(:av_notes, :venue_notes, :final_gurantee, :final_gurantee_count, :venue_name,:venue_address,:venue_contact_name,:venue_contact, expenses_attributes: [:id,:expense_type, :amount, :value_transfer_date,:payment_mode,:notes,:event_id])
   end
end
