require 'test_helper'

class BaseInfoTest < ActiveSupport::TestCase
  should "be valid" do
    assert BaseInfo.new.valid?
  end
end
