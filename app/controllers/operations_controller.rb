class OperationsController < ApplicationController
  before_filter :authenticate

  # GET /operations
  # GET /operations.xml
  def index
    @operations = Operation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @operations }
    end
  end

  # GET /operations/1
  # GET /operations/1.xml
  def show
    @operation = Operation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @operation }
    end
  end

  # GET /operations/new
  # GET /operations/new.xml
  def new
    @operation = Operation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @operation }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.find(params[:id])
  end

  # POST /operations
  # POST /operations.xml
  def create
    @operation = Operation.new(operation_params)
    @operation.current = true
    for operation in Operation.all
      operation.current = false
      operation.save
    end
    respond_to do |format|
      if @operation.save
        flash["notice"] = 'Operation was successfully created.'
        format.html { redirect_to(@operation) }
        format.xml  { render :xml => @operation, :status => :created, :location => @operation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @operation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /operations/1
  # PUT /operations/1.xml
  def update
    @operation = Operation.find(params[:id])

    respond_to do |format|
      if @operation.update_attributes(operation_params)
        flash["notice"] = 'Operation was successfully updated.'
        format.html { redirect_to(@operation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @operation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.xml
  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to(operations_url) }
      format.xml  { head :ok }
    end
  end

  private
  def operation_params
    params.require(:operation).permit(:name, :latitude, :longitude, :zoom, :width, :height, :postfix, :map, :smsurl, :tetraport)
  end
end
