require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    (@user = Factory(:user)).confirm!
    sign_in @user
    @item = @user.items.first
  end

  context "create action" do
    should "redirect when model is valid" do
      Account.any_instance.stubs(:valid?).returns(true)
      post :create, :format => 'json', :item_id => @item.id
      assert_response :success
    end
  end

  context "destroy action" do
    should "destroy model and response is ok" do
      assert_difference "@item.accounts.length", -1 do
        delete :destroy, :id => @item.accounts.first.id, :format => 'json', :item_id => @item.id
        @item.reload
        assert_response :success
      end
    end
    context "without not embeded id" do
      should "not destroy model and response is failure" do
        assert_difference "@item.accounts.length", 0 do
          delete :destroy, :id => 1, :format => 'json', :item_id => @item.id
          @item.reload
          assert_response 422
        end
      end
    end
  end
end
