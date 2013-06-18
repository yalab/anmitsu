# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :item do
    title "An Development"
    description "Create your CMS"
    note "note"
    client_name "よしだあつし"
#    association :user, :factory => :user
    after_build{|e| FactoryGirl.create(:account, :item => e) }
  end
end
