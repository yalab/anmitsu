class Account
  include Mongoid::Document
  field :content, :type => String
  field :price, :type => Integer
end
