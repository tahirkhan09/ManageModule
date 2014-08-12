class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to :controller => "events", :action => "new"
  end

end
