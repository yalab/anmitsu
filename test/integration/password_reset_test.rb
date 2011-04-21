require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest
  context "password reset flow" do
    setup do
      @user = FactoryGirl.create(:user)
      @user.confirm!
    end
    should "change password" do
      get new_user_password_url
      post user_password_url, :user => {:email => @user.email}
      @user.reload
      get edit_user_password_url, :reset_password_token => @user.reset_password_token
      old_password = @user.encrypted_password
      pass = old_password[0..12]
      put user_password_url, :user => {:password => pass, :password_confirmation => pass, :reset_password_token => @user.reset_password_token}
      @user.reload
      assert_not_equal old_password, @user.encrypted_password
    end
  end
end
