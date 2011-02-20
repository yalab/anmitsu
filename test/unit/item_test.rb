require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  setup do
    @item = Factory(:item)
  end
  [:title].each{|name| should validate_presence_of(name) }

  context "#tax" do
    setup do
      @item = Item.create(:title => 'title')
      @price = 100
      @account = @item.accounts.create(:content => 'content', :price => @price)
    end
    should "calculate" do
      tax = @price * 0.05
      assert_equal tax, @item.tax
      assert_equal tax + @price, @item.total_with_tax
    end
  end

  context "state change" do
    should "enter record time" do
      assert @item.estimated_at
      {:order    => :ordered_at,
       :delivery => :deliveried_at,
       :receipt  => :receipted_at}.each do |method, field|
        assert_equal nil, @item.send(field)
        @item.send("#{method}!")
        assert @item.send(field)
      end

    end
  end
end
