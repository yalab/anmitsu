require 'test_helper'

class RootControllerTest < ActionController::TestCase
  context "on GET :index" do
    setup do
      get :index
    end
    should "success" do
      assert_response :success
    end
    should "menu link is https" do
      ['logo-link', 'sign-in-link', 'sign-up-link'].each do |id|
        href = find_tag(:tag => 'a', :attributes => {:id => id}).attributes['href']
        assert_match REG_SSL, href
      end
    end
  end

end
