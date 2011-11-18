module Devise::MailerExt
  extend ActiveSupport::Concern
  included do
    default :charset => 'ISO-2022-JP'
  end
end

Devise::Mailer.send(:include, Devise::MailerExt)
