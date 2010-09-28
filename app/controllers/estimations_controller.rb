class EstimationsController < ApplicationController
  respond_to :html, :json
  def index
    respond_with(@estimations = Estimation.all)
  end

  def show
    respond_with(@estimation = Estimation.find(params[:id]))
  end

  def new
    respond_with(@estimation = Estimation.new)
  end

  def edit
    @estimation = Estimation.find(params[:id])
  end

  def create
    @estimation = Estimation.new(params[:estimation])
    return respond_with(@estimation) if @estimation.save

    respond_to do |f|
      f.html { render :action => "new" }
      f.json  { render :json => @estimation.errors, :status => :unprocessable_entity }
    end
  end

  def update
    @estimation = Estimation.find(params[:id])

    return respond_with(@estimation) if @estimation.update_attributes(params[:estimation])
    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @estimation.errors, :status => :unprocessable_entity }
    end
  end

  def destroy
    @estimation = Estimation.find(params[:id])
    (status, msg) = (@estimation.destroy) ?
      [:ok, {:notice => t('Destroy success')}] : [:unprocessable_entity, {:alert => t('Destroy failure')}]
    respond_to do |format|
      format.html { redirect_to(estimations_url, msg) }
      format.xml  { head status }
    end
  end
end
