require 'test_helper'

class Users::ConfirmationsControllerTest < ActionController::TestCase
  setup do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  context "on GET :new" do
    setup do
      get :new
    end
    should "success" do
      assert_response :success
    end
  end

  context "on GET :show" do
    setup do
      @user = FactoryGirl.create(:user)
      get :show, :confirmation_token => @user.confirmation_token
    end
    should "user is confirm" do
      assert_equal true, assigns(:user).confirmed?
    end
    should "redirect to items_path" do
      assert_redirected_to items_url
    end
  end
end
