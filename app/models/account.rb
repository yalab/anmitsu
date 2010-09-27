class Account
  include Mongoid::Document
  field :content, :type => String
  field :price, :type => Integer
  embedded_in :estimation, :inverse_of => :accounts
end
