# -*- coding: utf-8 -*-
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup{ I18n.locale = :ja }
  teardown{ I18n.locale = :en }
  context "create" do
    setup do
      @user = User.create(:email => 'test@example.com', :password => (pass = 'password'), :password_confirmation => pass)
      @mail = ActionMailer::Base.deliveries.last
    end

    should "generate information and bank_account" do
      assert_instance_of Information, @user.information
      assert_instance_of BankAccount, @user.bank_account
      assert_equal true, @user.beginner?
    end
    should "mail subject encded iso-2022-jp" do
      assert_match /ISO-2022-JP/, @mail.header[:subject].encoded
    end
    should "mail body is encoded iso-2022-jp" do
      expects = 'Anmitsu\e\$B\$K\$4EPO'.encode("BINARY")
      body = @mail.body.encoded.to_s.encode("BINARY")
      assert_match /#{expects}/, body
    end
  end
end
