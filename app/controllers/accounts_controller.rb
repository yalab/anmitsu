class AccountsController < ApplicationController
  respond_to :json

  def create
    @account = item.accounts.build(params[:account])
    @account.save
    respond_with(@account)
  end

  def destroy
    @account = item.accounts.find(params[:id])
    status = (@account && @account.destroy) ? :ok : :unprocessable_entity
    respond_to{|f| f.json{ render :json => @account, :status => status } }
  end

  private
  def item
    current_user.items.find(params[:item_id])
  end
end
