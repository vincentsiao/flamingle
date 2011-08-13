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
    
    @mission.refresh_status
    MissionAttempt.create(:user_id => current_user.id, 
                          :mission_id => @mission.id, 
                          :mission_attempt_status_id => MissionAttemptStatus.find_by_name("In Progress"))

    flash[:notice] = "You're now attempting '" + @mission.title + "'. Good Luck!"
    redirect_to dashboard_url
    return
  end

  def update
    @attempt = MissionAttempt.find_by_mission_id_and_user_id(params[:id], current_user.id)
    @attempt.mission_attempt_status = MissionAttemptStatus.find_by_name("Done")
    
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

    @attempt = @mission.mission_attempts.find_by_user_id(current_user.id)
    @attempt.destroy

    @mission.refresh_status
    flash[:notice] = "You've abandoned your mission attempt."
    redirect_to dashboard_url
    return
  end
end
