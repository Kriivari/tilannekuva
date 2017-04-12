class CodesController < ApplicationController
  before_action :authenticate_user!

  # GET /codes
  # GET /codes.xml
  def index
    @codes = []
    if params[:sort]
      codes = Code.order("explanation").all
    else
      codes = Code.order("code").all
    end
    previous = ""
    prevexplanation = ""
    urgencies = []
    for code in codes
      if code.code.length == 4 && code.code[0,3].to_i > 0
        if previous != code.code[0,3]
          if previous.length > 0
            @codes << [previous + urgencies.sort().join(), prevexplanation]
          end
          previous = code.code[0,3]
          prevexplanation = code.explanation
          urgencies = []
          urgencies << code.code[3,1]
        else
          urgencies << code.code[3,1]
        end
      else
        @codes << [code.code, code.explanation]
      end
    end
    @codes << [previous + urgencies.sort().join(), prevexplanation]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @codes }
    end
  end

  # GET /codes/1
  # GET /codes/1.xml
  def show
    @code = Code.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @code }
    end
  end

  # GET /codes/new
  # GET /codes/new.xml
  def new
    @code = Code.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code }
    end
  end

  # GET /codes/1/edit
  def edit
    @code = Code.find(params[:id])
  end

  # POST /codes
  # POST /codes.xml
  def create
    @code = Code.new(params[:code])

    respond_to do |format|
      if @code.save
        flash["notice"] = 'Code was successfully created.'
        format.html { redirect_to(@code) }
        format.xml  { render :xml => @code, :status => :created, :location => @code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /codes/1
  # PUT /codes/1.xml
  def update
    @code = Code.find(params[:id])

    respond_to do |format|
      if @code.update_attributes(params[:code])
        flash["notice"] = 'Code was successfully updated.'
        format.html { redirect_to(@code) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.xml
  def destroy
    @code = Code.find(params[:id])
    @code.destroy

    respond_to do |format|
      format.html { redirect_to(codes_url) }
      format.xml  { head :ok }
    end
  end
end
