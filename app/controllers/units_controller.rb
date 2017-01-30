class UnitsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate
  
  # GET /units
  # GET /units.xml
  def index
    @operation = Operation.active.first
    @event = Event.new
    @units = Unit.real
    queue = Unit.queue.first.events
    @queue = []
    for q in queue
      if q.archived == nil
        @queue << q
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @units }
    end
  end

  # GET /view
  # GET /view.xml
  def view
    @operation = Operation.active.first
    @units = Unit.real
    queue = Unit.queue.first.events
    @queue = []
    for q in queue
      if q.archived == nil
        @queue << q
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @units }
    end
  end

  # GET /units/1
  # GET /units/1.xml
  def show
    @unit = Unit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unit }
    end
  end

  # GET /units/new
  # GET /units/new.xml
  def new
    @unit = Unit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unit }
    end
  end

  # GET /units/1/edit
  def edit
    @unit = Unit.find(params[:id])
  end

  # POST /units
  # POST /units.xml
  def create
    @unit = Unit.new(params[:unit])
    @unit.listorder = 1

    respond_to do |format|
      if @unit.save
        flash["notice"] = 'Unit was successfully created.'
        format.html { redirect_to(@unit) }
        format.xml  { render :xml => @unit, :status => :created, :location => @unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /units/1
  # PUT /units/1.xml
  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        flash["notice"] = 'Unit was successfully updated.'
        format.html { redirect_to(@unit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.xml
  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy

    respond_to do |format|
      format.html { redirect_to(units_url) }
      format.xml  { head :ok }
    end
  end

  # GET /units/available
  def available
    @units = Unit.virtual
  end

  # POST /units/changeavailability
  def changeavailability
    @units = Unit.virtual
    for unit in @units
      sym = ("available_" + unit.id.to_s).to_sym
      if params[sym] != nil
        unit.listorder = 1
      else
        unit.listorder = -1
      end
      unit.save!
    end
    render :action => "available"
  end

  # GET /unit
  def unit
    @operation = Operation.active.first
    @unit = Unit.find_by_unit(params[:id])
    if @unit == nil
      @unit = Unit.find(params[:id])
    end
    @states = State.all
    @units = [@unit]

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /status
  def status
    @operation = Operation.active.first
    @unit = Unit.find(params[:id])
    s = State.find_by_state(params[:submit])
    @unit.state = s
    event = Event.new
    if s.id == 5
      event.location = Location.find(params[:event][:location_id])
      @unit.location = event.location
    else
      event.location = @unit.location
    end
    event.state = s
    event.unit = @unit
    if s.id > 1 and s.id < 7
      event.code = @unit.currentcode
    end
    event.save
    @unit.save
    @units = [@unit]

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /get_latest_event
  def update_unit
    @unit = Unit.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
end
