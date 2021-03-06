require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "/gems/"
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  extend Mongoid::Matchers
end

class ActionController::TestCase
  include Devise::TestHelpers
  setup{ @request.env['HTTPS'] = 'on' }

  def flash
    f = super
    [:notice, :alert].each do |k|
      f[k].gsub! /^translation missing: en\./, '' if f[k]
    end
    f
  end
end

class ActionDispatch::IntegrationTest
  setup{ https! }
end
Mongoid.master.collections.select{ |c| c.name !~ /system\./ }.each { |c| c.drop }
Dir.glob("#{Rails.root}/test/factories/*.rb"){|factory| require factory }
