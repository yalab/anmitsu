FactoryGirl.define do
  factory :account do
    content "Design"
    price 1
    item{ FactoryGirl.create(:item) }
  end
end
