class InformationController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def edit
    @information    = current_user.information
    @bank_account = current_user.bank_account
  end

  def update
    @information = current_user.information
    @information.update_attributes(params[:information])
    @bank_account = current_user.bank_account
    @bank_account.update_attributes(params[:bank_account])
    respond_with(@information) do |f|
      f.html{ redirect_to items_path, :notice => t('Update success') }
    end
  end
end
