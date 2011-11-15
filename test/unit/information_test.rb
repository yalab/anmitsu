require 'test_helper'

class InformationTest < ActiveSupport::TestCase
  should "be valid" do
    assert Information.new.valid?
  end
  should be_embedded_in(:user)
  [:name, :address, :tel, :fax, :email].each do |name|
    should have_field(name).of_type(String)
  end
end
