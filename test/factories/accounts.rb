FactoryGirl.define do
  factory :account do
    content "Design"
    price 1
    association :item, :factory => :item
  end
end
