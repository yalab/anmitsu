require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @estimation = Factory(:estimation)
    @account = @estimation.accounts.first
  end
  [:price, :content].each{|name| should validate_presence_of(name) }
end
