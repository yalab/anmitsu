require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = Factory(:account)
  end
  context "create action" do
    should "redirect when model is valid" do
      #Account.any_instance.stubs(:valid?).returns(true)
      post :create, :format => 'json'
      assert_response :success
    end
  end

  context "destroy action" do
    should "destroy model and redirect to index action" do
      assert_difference "Account.count", -1 do
        delete :destroy, :id => @account.to_param, :format => 'json'
      end
    end
  end
end
