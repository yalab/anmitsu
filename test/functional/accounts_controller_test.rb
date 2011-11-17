require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = FactoryGirl.create(:account)
    @item = @account.item
    @user = @item.user
    @user.confirm!
    sign_in @user
  end

  context "create action" do
    context "valid params" do
      setup do
        post :create, :format => 'json', :item_id => @item.id, :account => {:price => "3000", :content => 'foobar'}
      end
      should "success" do
        assert_response :success
      end
      should "response is json" do
        assert_equal Hash, response.json.class
      end
    end
  end

  context "destroy action" do
    should "destroy model and response is ok" do
      assert_difference "@item.accounts.length", -1 do
        delete :destroy, :id => @account.to_param, :format => 'json', :item_id => @item.id
        assert_response :success
        @item.reload
      end
    end
    context "without not embeded id" do
      should "not destroy model and response is failure" do
        assert_difference "@item.accounts.length", 0 do
          assert_raise(Mongoid::Errors::DocumentNotFound){
            delete :destroy, :id => 1, :format => 'json', :item_id => @item.id
          }
        end
      end
    end
  end
end
