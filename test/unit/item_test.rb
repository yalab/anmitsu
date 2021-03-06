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


  context ".title_or_client" do
    should "blank line not create scope" do
      assert_equal Hash.new, Item.title_or_client("").selector
    end
    should "present line create scope" do
      assert_equal({"$or"=>[{:client_name=>/yalab/}, {:title=>/yalab/}]}, Item.title_or_client("yalab").selector)
    end
  end

  context ".state_is" do
    should "add blank line not create scope" do
      assert_equal Hash.new, Item.state_is("").selector
    end
    should "add present line create scope" do
      assert_equal({:state=>"estimate"}, Item.state_is("estimate").selector)
    end
  end

  context ".client_name_like" do
    should "add blank line not create scope" do
      assert_equal Hash.new, Item.client_name_like("").selector
    end
    should "add present line create scope" do
      assert_equal({:client_name=>/yal/}, Item.client_name_like("yal").selector)
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
