require 'csv'
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

  def create_all
    @item = item
    _group = nil
    CSV.parse(params[:account][:file].read).each.with_index do |cols, i|
      next if i == 0
      (group, content, note, price) = cols
      _group = group if group.present?
      content = [_group, content].select{|s| s.present? }.join(' - ')
      price.gsub!(/,/, '')
      account = @item.accounts.create(item_id: @item.id, price: price, content: content)
    end
    redirect_to item
  end

  private
  def item
    current_user.items.find(params[:item_id])
  end
end
