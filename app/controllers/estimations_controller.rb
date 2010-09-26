class EstimationsController < ApplicationController
  # GET /estimations
  # GET /estimations.xml
  def index
    @estimations = Estimation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estimations }
    end
  end

  # GET /estimations/1
  # GET /estimations/1.xml
  def show
    @estimation = Estimation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estimation }
    end
  end

  # GET /estimations/new
  # GET /estimations/new.xml
  def new
    @estimation = Estimation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estimation }
    end
  end

  # GET /estimations/1/edit
  def edit
    @estimation = Estimation.find(params[:id])
  end

  # POST /estimations
  # POST /estimations.xml
  def create
    @estimation = Estimation.new(params[:estimation])

    respond_to do |format|
      if @estimation.save
        format.html { redirect_to(@estimation, :notice => 'Estimation was successfully created.') }
        format.xml  { render :xml => @estimation, :status => :created, :location => @estimation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estimation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estimations/1
  # PUT /estimations/1.xml
  def update
    @estimation = Estimation.find(params[:id])

    respond_to do |format|
      if @estimation.update_attributes(params[:estimation])
        format.html { redirect_to(@estimation, :notice => t('Estimation was successfully updated.')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estimation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estimations/1
  # DELETE /estimations/1.xml
  def destroy
    @estimation = Estimation.find(params[:id])
    @estimation.destroy

    respond_to do |format|
      format.html { redirect_to(estimations_url) }
      format.xml  { head :ok }
    end
  end
end
