require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @item = Factory(:item)
    @account = @item.accounts.first
  end
  [:price, :content].each{|name| should validate_presence_of(name) }
  should validate_numericality_of(:price)
  context "#serializable_hash" do
    should "insert Item#total and Item#total_with_tax" do
      account = @item.accounts.create(:title => 'foobar', :price => 100)
      serialized = account.serializable_hash
      assert_equal "#{@account.price + account.price}", serialized['item_total']
      with_tax = (@account.price + account.price) * 1.05
      assert_equal "#{with_tax.truncate}", serialized['item_total_with_tax']
      assert_equal '$', serialized['unit']
    end
  end
end
