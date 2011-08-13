class MissionAttemptsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @mission = Mission.find(params[:id])
    authorize! :accept, @mission
    
    MissionAttempt.create(:user_id => current_user.id, 
                          :mission_id => @mission.id, 
                          :status => 'Attempting')

    flash[:notice] = "You're now attempting '" + @mission.title + "'. Good Luck!"
    redirect_to dashboard_url
    return
  end

  def update
    @attempt = MissionAttempt.find(params[:id])
    @attempt.status = "Complete"
    
    if !@attempt.save 
      flash[:error] = "We can't complete your mission attempt at the moment. Please try again later."
      
    end
    ddredirect_to dashboard_url 
    return
  end

  def destroy
  end
end
