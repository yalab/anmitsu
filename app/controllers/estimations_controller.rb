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
    @estimation.save
    respond_with(@estimation)
  end

  def update
    @estimation = Estimation.find(params[:id])
    @estimation.update_attributes(params[:estimation])
    respond_with(@estimation)
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
