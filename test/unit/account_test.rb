require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should "be valid" do
    assert Account.new.valid?
  end
end
