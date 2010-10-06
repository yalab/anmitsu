class BaseInfosController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!

  def edit
    @base_info    = current_user.base_info
    @bank_account = current_user.bank_account
  end

  def update
    @base_info = current_user.base_info
    @base_info.update_attributes(params[:base_info])
    @bank_account = current_user.bank_account
    @bank_account.update_attributes(params[:bank_account])
    respond_with(@base_info) do |f|
      f.html{ redirect_to root_path }
    end
  end
end
