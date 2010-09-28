require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @account = Factory(:account)
  end
  [:price, :content].each{|name| should validate_presence_of(name) }
end
