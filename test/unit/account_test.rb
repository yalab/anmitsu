require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @item = Factory(:item)
    @account = @item.accounts.first
  end
  [:price, :content].each{|name| should validate_presence_of(name) }
  context "#to_json" do
    should "insert Item#total and Item#total_with_tax" do
      account = @item.accounts.create(:title => 'foobar', :price => 100)
      json = ActiveSupport::JSON.decode(account.to_json)
      assert_equal @account.price + account.price, json['item_total']
      with_tax = (@account.price + account.price) * 1.05
      assert_equal with_tax.truncate, json['item_total_with_tax']
    end
  end
end
