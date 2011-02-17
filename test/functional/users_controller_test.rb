require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  context "on POST :create" do
    context "valid params" do
      setup do
        @original_locale = I18n.default_locale
        I18n.default_locale = :ja
      end
      teardown do
        I18n.default_locale = @original_locale
      end

      should "create user" do
        assert_difference('User.count', +1) do
          pass = 'password'
          post :create, :user => {:email => Faker::Internet.email, :password => pass, :password_confirmation => pass}
        end
      end
    end
  end
end
