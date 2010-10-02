# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :base_info do |f|
  f.name "MyString"
  f.address "MyText"
  f.tel "MyString"
  f.fax "MyString"
  f.email "MyString"
end
