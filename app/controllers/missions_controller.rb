class MissionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource

  # GET /missions
  # GET /missions.xml
  def index
    @missions = Mission.all(:include => :user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @missions }
    end
  end

  # GET /missions/1
  # GET /missions/1.xml
  def show
    # @mission = Mission.find(params[:id], :include => :user)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mission }
    end
  end

  # GET /missions/new
  # GET /missions/new.xml
  def new
    # @mission = Mission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mission }
    end
  end

  # GET /missions/1/edit
  def edit
    # @mission = Mission.find(params[:id])
  end

  # POST /missions
  # POST /missions.xml
  def create
    @mission = current_user.missions.create(params[:mission])

    respond_to do |format|
      if @mission.save
        format.html { redirect_to(@mission, :notice => 'Mission was successfully created.') }
        format.xml  { render :xml => @mission, :status => :created, :location => @mission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /missions/1
  # PUT /missions/1.xml
  def update
    # @mission = Mission.find(params[:id])

    respond_to do |format|
      if @mission.update_attributes(params[:mission])
        format.html { redirect_to(@mission, :notice => 'Mission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.xml
  def destroy
    # @mission = Mission.find(params[:id])
    @mission.destroy

    respond_to do |format|
      format.html { redirect_to(missions_url) }
      format.xml  { head :ok }
    end
  end
end
