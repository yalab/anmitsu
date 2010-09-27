class AccountsController < ApplicationController
  respond_to :json
  def create
    @account = current_estimation.accounts.build(params[:account])
    @account.save
    respond_with([current_estimation, @account])
  end

  def destroy
    @account = current_estimation.accounts.find(params[:id])
    if @account && @account.destroy
      respond_to{|f| f.json{ head :ok } }
    else
      respond_to{|f| f.json{ head :unprocessable_entity } }
    end
  end
  private
  def current_estimation
    Estimation.find(params[:estimation_id])
  end
end
