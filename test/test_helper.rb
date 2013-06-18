require 'simplecov'
SimpleCov.start 'rails' do
  add_filter "/gems/"
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


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
Dir.glob("#{Rails.root}/test/factories/*.rb"){|factory| require factory }
