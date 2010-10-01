require 'test_helper'

class EstimationTest < ActiveSupport::TestCase
  setup do
    @estimation = Factory(:estimation)
  end
  [:title].each{|name| should validate_presence_of(name) }
end
