ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
class ActiveSupport::TestCase
end
class ActionController::TestCase
  include Devise::TestHelpers
  REG_SSL = %r|^https://|
  def flash
    f = super
    [:notice, :alert].each do |k|
      f[k].gsub! /^translation missing: en\./, '' if f[k]
    end
    f
  end
end
Mongoid.master.collections.select{ |c| c.name !~ /system\./ }.each { |c| c.drop }
Dir.glob("#{Rails.root}/test/factories/*.rb"){|factory| require factory }


