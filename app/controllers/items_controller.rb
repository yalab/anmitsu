class ItemsController < ApplicationController
  respond_to :html, :json
  respond_to :pdf, :only => [:show]
  before_filter :authenticate_user!

  def index
    per_page = 10
    respond_with(@items = current_user.items.paginate(:page => params[:page], :per_page => per_page))
  end

  def show
    respond_with(@item = current_user.items.find(params[:id])) do |format|
      format.pdf{ render :pdf => @item }
    end
  end

  def new
    respond_with(@item = current_user.items.new)
  end

  def edit
    @item = current_user.items.find(params[:id])
  end

  def create
    @item = current_user.items.new(params[:item])
    @item.user = current_user
    if @item.save
      flash[:notice] = t('Item was successfully created')
    else
      flash[:alert]  = t('Failed to delete')
    end
    respond_with(@item)
  end

  def update
    @item = current_user.items.find(params[:id])
    if @item.update_attributes(params[:item])
      flash[:notice] = t('Item was successfully updated')
    else
      flash[:alert] = t('Failed to update')
    end
    respond_with(@item)
  end

  def destroy
    @item = current_user.items.find(params[:id])
    (status, msg) = (@item.destroy) ?
    [:ok, {:notice => t('Destroy success')}] : [:unprocessable_entity, {:alert => t('Destroy failure')}]
    respond_with(@item) do |format|
      format.html { redirect_to(items_url, msg) }
      format.json  { head status }
    end
  end
end
