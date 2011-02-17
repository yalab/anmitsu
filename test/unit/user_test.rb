require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "create" do
    setup do
      @user = User.create(:email => 'test@example.com', :password => (pass = 'password'), :password_confirmation => pass)
    end
    should "generate information and bank_account" do
      assert_instance_of Information,    @user.information
      assert_instance_of BankAccount, @user.bank_account
    end
  end
end
