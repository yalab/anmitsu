require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
        
  context "create action" do
    should "render new template when model is invalid" do
      Account.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
    
    should "redirect when model is valid" do
      Account.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to
    end
  end
        
  context "destroy action" do
    should "destroy model and redirect to index action" do
      accounts = Account.first
      delete :destroy, :id => accounts
      assert_redirected_to
      assert !Account.exists?(accounts.id)
    end
  end
    
end
