class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @attempted_missions = current_user.attempted_missions
  end

end
