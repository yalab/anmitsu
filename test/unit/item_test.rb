require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  setup do
    @item = Factory(:item)
  end
  [:title].each{|name| should validate_presence_of(name) }
end
