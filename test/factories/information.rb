FactoryGirl.define do
  factory :information do
    name "Enterprise Neet co.ltd"
    address "Suita Osaka"
    tel "090-4279-9916"
    fax "06-6666-6666"
    email "rudeboyjet@gmail.com"
    association :user, :factory => :user
  end
end
