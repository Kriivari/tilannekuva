class EventsController < ApplicationController
  before_action :authenticate

  # GET /events
  # GET /events.xml
  def index
    @events = Event.where(archived: nil).order("updated_at desc").all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /byunit
  def byunit
    @events = Event.where(archived: nil).order("unit_id, updated_at desc").all

    respond_to do |format|
      format.html { render :action => "index" }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # GET /events/comment
  def comment
    @event = Event.new
  end

  # POST /events/newcomment
  def newcomment
    @event = Event.new(event_params)
    @event.save

    respond_to do |format|
      format.html { redirect_to :controller => "unit", :action => "index" }
    end
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(event_params)
    current = @event.unit.get_current_event
    locationtext = params[:new_event][:location_id]
    if @event.unit.id != -1 && (@event.state.id == 1 || @event.state.id == 9)
      @event.code = nil
    end
    if current != nil
      if @event.state.id == 0
        @event.state = current.state
      end
      if @event.state.id > 1 && @event.state.id < 9
        if @event.code == nil || @event.code.id == 0
          @event.code = current.code
        end
        if (locationtext == nil || locationtext.length == 0) && (@event.message == nil || @event.message.length == 0)
          @event.message = current.message
        end
      end
      if locationtext == nil || locationtext.length == 0
        @event.location = current.location
      end
    end

    if ! @event.location || ( @event.location.id == 0 && locationtext && locationtext.length > 0 )
      location = Location.find_by_location(locationtext)
      if ! location
        usname = locationtext;
        split = locationtext.split(" ");
        usname = split[1] + "," + split[0] if split.length > 1
        usname = usname + ',Helsinki,Finland'
        logger.info('Requesting ' + usname)
        results = Geocoder.search(usname)
        location = Location.create
        location.location = locationtext
        location.type_id = 0
        location.lat = results.first.coordinates[0]
        location.lon = results.first.coordinates[1]
        location.save
      end
      @event.location = location
    end
    @event.unit.state = @event.state
    @event.unit.location = @event.location
    if @event.location.lat
      @event.unit.lat = @event.location.lat
      @event.unit.lon = @event.location.lon
    end

    respond_to do |format|
      if @event.save! && @event.unit.save!
        if params[:previous] == "unit"
          format.html { redirect_to :controller => "units", :action => "index" }
        else
          format.html { redirect_to :action => "new" }
        end
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        @event.unit.state = @event.state
        @event.unit.location = @event.location
        @event.unit.save
        operation = Operation.where(current: true).take
        if operation && operation.smsurl && @event.unit.phone
          begin
            client = Twilio::REST::Client.new operation.smsurl, operation.smstoken
            number = client.account.messages.create({from: operation.smsfrom, to: @event.unit.phone, body: @event.unit.unit + ": " + @event.code.code + " (" + @event.code.explanation + ") " + @event.location.location + "; " + @event.message})
            logger.info("Sent message to " + @event.unit.phone)
          rescue Exception
            logger.info("Not able to send SMS")
          end
        end
        if operation && operation.tetraport && operation.tetraport.length > 0 && @event.unit.phone
          require "serialport"
          begin
	    serial = SerialPort.new operation.tetraport, 9600
	    serial.write "AT+CTSDS=13,0\r\n"
	    serial.read
	    serial.write "AT+CMGS=\"" + @event.unit.phone + "\",16\r\n"
	    serial.write "FEFD\r\n"
	    serial.write 26
	    serial.read
            logger.info("Sent alarm to " + @event.unit.phone + ": " + result)
          rescue Exception
            logger.info("Not able to send TETRA status")
          end
        end
        format.html { redirect_to(units_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def drag
    unit = Unit.find(params[:id])
    unit.lat = params[:lat]
    unit.lon = params[:lon]
    unit.save!

    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  def breaks
    @events = Event.where(archived: nil, state_id: 8).order("created_at desc").all
  end

  def archive
    events = Event.where(archived: nil).all
    for event in events
      event.archived = Time.now
      event.save
    end
    units = Unit.all
    free = State.where(state: 'Vapaa').first
    for unit in units
      if unit.listorder == 1
        unit.listorder = -1
      end
      unit.state = free
      unit.location = nil
      unit.save
    end
    redirect_to :action => "index"
  end

  def statistics
    @transports = Event.transport.size
    @customers = Event.customer.size
    @reachtotal = 0
    @reachcount = 0
    @transporttotal = 0
    @transportcount = 0
    for unit in Unit.all
      events = Event.where(["archived is null and unit_id=?", unit.id]).order("updated_at").all
      reaching = false
      transporting = false
      reachstart = nil
      for event in events
        if event.state_id == 1 || event.state_id > 6
          reaching = false
          transporting = false
        end
        if event.state_id == 2 && ! reaching
          transporting = false
          reaching = true
          reachstart = event.created_at
        end
        if reaching && ( event.state_id == 3 || event.state_id == 4 )
          @reachcount += 1
          @reachtotal += event.updated_at - reachstart
          reaching = false
          transporting = true
        end
        if transporting && event.state_id == 6
          @transportcount += 1
          @transporttotal += event.updated_at - reachstart
          transporting = false
        end
      end
    end
    if @reachcount == 0
      @reachcount = 1
    end
    if @transportcount == 0
      @transportcount = 1
    end
  end

  def sms
    event = Event.new
    text = params[:text]
    code = text.match("[0-9][0-9][0-9][a-dA-D]").to_s
    if ! code
      code = text.match("[a-dA-D][0-9][0-9][0-9]").to_s
    end
    if code
      code = code.upcase
      event.code = Code.where(code: code).first
    end
    event.unit_id = 0
    event.message = text
    event.save
  end

  private
  def event_params
    params.require(:event).permit(:code_id, :location_id, :state_id, :unit_id, :from_hq, :message, :archived)
  end
end
