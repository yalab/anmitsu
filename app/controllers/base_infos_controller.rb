class BaseInfosController < ApplicationController
  respond_to :html, :json
  def index
    respond_with(@base_infos = BaseInfo.all)
  end

  def show
    respond_with(@base_info = BaseInfo.find(params[:id]))
  end

  def new
    respond_with(@base_info = BaseInfo.new)
  end

  def edit
    @base_info = BaseInfo.find(params[:id])
  end

  def create
    @base_info = BaseInfo.new(params[:base_info])
    @base_info.save
    respond_with(@base_info)
  end

  def update
    @base_info = BaseInfo.find(params[:id])
    @base_info.update_attributes(params[:base_info])
    respond_with(@base_info)
  end

  def destroy
    @base_info = BaseInfo.find(params[:id])
    (status, msg) = (@base_info.destroy) ?
      [:ok, {:notice => t('Destroy success')}] : [:unprocessable_entity, {:alert => t('Destroy failure')}]
    respond_with(@base_info) do |format|
      format.html { redirect_to(base_infos_url, msg) }
      format.json  { head status }
    end
  end
end
