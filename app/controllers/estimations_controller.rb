class EstimationsController < ApplicationController
  respond_to :html, :json
  respond_to :pdf, :only => [:show]
  before_filter :authenticate_user!

  def index
    respond_with(@estimations = current_user.estimations.all)
  end

  def show
    respond_with(@estimation = current_user.estimations.find(params[:id])) do |format|
      format.pdf{ render :pdf => @estimation }
    end
  end

  def new
    respond_with(@estimation = current_user.estimations.new)
  end

  def edit
    @estimation = current_user.estimations.find(params[:id])
  end

  def create
    @estimation = current_user.estimations.new(params[:estimation])
    @estimation.user = current_user
    @estimation.save
    respond_with(@estimation)
  end

  def update
    @estimation = current_user.estimations.find(params[:id])
    @estimation.update_attributes(params[:estimation])
    respond_with(@estimation)
  end

  def destroy
    @estimation = current_user.estimations.find(params[:id])
    (status, msg) = (@estimation.destroy) ?
    [:ok, {:notice => t('Destroy success')}] : [:unprocessable_entity, {:alert => t('Destroy failure')}]
    respond_with(@estimation) do |format|
      format.html { redirect_to(estimations_url, msg) }
      format.json  { head status }
    end
  end
end
