require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Anmitsu
  class Application < Rails::Application
    config.time_zone = 'Osaka'
    config.i18n.default_locale = :ja
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails application)
    config.encoding = "utf-8"
    config.filter_parameters += [:password, :password_confirmation]
    config.generators do |g|
      g.orm :mongoid
      g.test_framework  :shoulda, :fixture_replacement => :factory_girl
      g.fallbacks[:shoulda] = :test_unit
    end
  end
end
