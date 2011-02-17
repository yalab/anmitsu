require 'test_helper'

class InformationTest < ActiveSupport::TestCase
  should "be valid" do
    assert Information.new.valid?
  end
end
