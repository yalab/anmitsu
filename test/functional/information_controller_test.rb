require 'test_helper'

class InformationControllerTest < ActionController::TestCase
  setup do
    @user = Factory(:user)
    @user.confirm!
    sign_in @user
    @information = @user.information
  end

  should "get edit" do
    get :edit, :id => @information.to_param
    assert_response :success
  end

  should "update information" do
    bank_name = 'Foo Bar Bank'
    put :update, :id => @information.to_param, :information => @information.attributes, :bank_account => {:name => bank_name}
    assert_equal bank_name, User.find(@user.id).bank_account.name
    assert_redirected_to items_path
  end
end
