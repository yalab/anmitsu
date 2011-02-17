Factory.define :information do |f|
  f.name "Enterprise Neet co.ltd"
  f.address "Suita Osaka"
  f.tel "090-4279-9916"
  f.fax "06-6666-6666"
  f.email "rudeboyjet@gmail.com"
  f.association :user, :factory => :user
end
