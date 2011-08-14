class MissionAttemptsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def create
    @mission = Mission.find(params[:id])
    authorize! :accept, @mission
    
    @mission.mission_attempts.new(current_user)
    @mission.refresh_status
    
    flash[:notice] = "You're now attempting '" + @mission.title + "'. Good Luck!"
    redirect_to dashboard_url
    return
  end

  def update
    @mission = Mission.find(params[:id])
    @attempt = @mission.mission_attempts.find_by_user_id(current_user.id)
    @attempt.status = "Done"
    @attempt.mission.status = "Pending Approval"
    
    if @attempt.save 
      flash[:notice] = "Well done! You'll receive your reward when " + @attempt.mission.user.username + " approves your attempt."
    else
      flash[:error] = "We can't complete your mission attempt at the moment. Please try again later." 
    end
    redirect_to dashboard_url 
    return
  end

  def destroy
    @mission = Mission.find(params[:id])
    authorize! :abandon, @mission
   
    @mission.mission_attempts.abandon(current_user)
    @mission.refresh_status
    
    flash[:notice] = "You've abandoned your mission attempt."
    redirect_to dashboard_url
    return
  end
end
