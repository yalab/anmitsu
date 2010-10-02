require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "create" do
    setup do
      @user = User.create(:email => 'test@example.com', :password => (pass = 'password'), :password_confirmation => pass)
    end
    should "generate base_info" do
      assert_instance_of BaseInfo, @user.base_info
    end
  end
end
