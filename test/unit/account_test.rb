require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @item = Factory(:item)
    @account = @item.accounts.first
  end
  [:price, :content].each{|name| should validate_presence_of(name) }
end
