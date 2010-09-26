require 'test_helper'

class EstimationTest < ActiveSupport::TestCase
  should "be valid" do
    assert Estimation.new.valid?
  end
end
