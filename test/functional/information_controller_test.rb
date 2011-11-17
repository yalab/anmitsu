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

  context "on PUT :update" do
    context "valid params" do
      setup do
        @bank_name = 'Foo Bar Bank'
        put :update, :id => @information.to_param, :information => @information.attributes, :bank_account => {:name => @bank_name}
      end
      should "update information" do
        assert_equal @bank_name, User.find(@user.id).bank_account.name
      end
      should "redirect" do
        assert_redirected_to items_path
      end
    end
  end
end
