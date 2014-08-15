class SignInSheetController < ApplicationController
  def index
  end

  def add_sign_in_sheet
    @sign_in_sheet = SignInSheet.where(:event_id => params[:event_id]).first
    if @sign_in_sheet.present?
      @sign_in_sheet.update_attributes(params_sign_in_sheet)
      else
        @sign_in_sheet = SignInSheet.new(params_sign_in_sheet)
        @sign_in_sheet.event_id = params[:event_id]
        @sign_in_sheet.save
      end
    redirect_to :controller => "events", :action => "index"



  end

  private
  def params_sign_in_sheet
    params[:sign_in_sheet].permit(:non_profiled_attendee,:prescribing_attendee,:client_employee_attendee,:speaker)
  end


end
