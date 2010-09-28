ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'shoulda/active_model'
class ActiveSupport::TestCase
end
class ActionController::TestCase
  include Devise::TestHelpers
end
Mongoid.master.collections.select{ |c| c.name !~ /system\./ }.each { |c| c.drop }
Dir.glob("#{Rails.root}/test/factories/*.rb"){|factory| require factory }


