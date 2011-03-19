require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  context "on GET :index" do
    setup do
      @item = FactoryGirl.create(:item)
      @user = @item.user
      @user.confirm!
      sign_in @user
    end
    context "known params" do
      setup do
        get :index, :format => :json, :item => {:client_name => @item.client_name.to_roma[0, 2]}
      end
      should "fetch record" do
        assert_equal 1, response.json.length
      end
      should "content is client name" do
        assert_equal @item.client_name, response.json.first
      end
    end
    context "not known params" do
      setup do
        get :index, :format => :json, :item => {:client_name => @item.client_name.to_roma[0, 2].reverse}
      end
      should "fetch nothing" do
        assert_equal 0, response.json.length
      end
    end
  end
end
