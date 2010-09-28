class AccountsController < ApplicationController
  respond_to :json

  def create
    @account = current_estimation.accounts.build(params[:account])
    @account.save
    respond_with(@account)
  end

  def destroy
    @account = current_estimation.accounts.find(params[:id])
    status = (@account && @account.destroy) ? :ok : :unprocessable_entity
    respond_to{|f| f.json{ head status } }
  end

  private
  def current_estimation
    Estimation.find(params[:estimation_id])
  end
end
