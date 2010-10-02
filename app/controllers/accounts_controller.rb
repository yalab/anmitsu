class AccountsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  respond_to :json

  def create
    @account = estimation.accounts.build(params[:account])
    @account.save
    @account.price = number_to_currency(@account.price)
    respond_with(@account)
  end

  def destroy
    @account = estimation.accounts.find(params[:id])
    status = (@account && @account.destroy) ? :ok : :unprocessable_entity
    respond_to{|f| f.json{ head status } }
  end

  private
  def estimation
    current_user.estimations.find(params[:estimation_id])
  end
end
