class AccountsController < ApplicationController
  respond_to :json
  def create
    @account = Account.new(params[:account])
    @account.save
    respond_with(@account)
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    respond_to do |f|
      f.json{ head :ok }
    end
  end
end
