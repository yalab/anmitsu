require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end
  context "on POST :create" do
    context "valid params" do
      should "create user" do
        assert_difference('User.count', +1) do
          pass = 'password'
          post :create, :user => {:email => Faker::Internet.email, :password => pass, :password_confirmation => pass}
          assert_redirected_to users_registered_url
        end
      end
    end

    context "invalid params" do
      setup do
        post :create, :user => {:email => "", :password => pass}
      end
      should "render new" do
        assert_template 'new'
      end
      should "display error message" do
        assert_tag :tag => 'span', :attributes => { :class => "alert" }
      end
    end
  end
end
