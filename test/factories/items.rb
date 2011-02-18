FactoryGirl.define do
  factory :item do
    title "An Development"
    description "Create your CMS"
    note "note"
    client_name "yalab"
    after_build{|e| FactoryGirl.create(:account, :item => e) }
  end
end
