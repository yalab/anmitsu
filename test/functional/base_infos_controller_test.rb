require 'test_helper'

class BaseInfosControllerTest < ActionController::TestCase
  setup do
    @user = Factory(:user)
    @user.confirm!
    sign_in @user
    @base_info = @user.base_info
  end

  should "get edit" do
    get :edit, :id => @base_info.to_param
    assert_response :success
  end

  should "update base_info" do
    put :update, :id => @base_info.to_param, :base_info => @base_info.attributes
    assert_redirected_to root_path
  end
end
