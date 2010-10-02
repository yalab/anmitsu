class BaseInfo
  include Mongoid::Document
  field :name, :type => String
  field :address, :type => String
  field :tel, :type => String
  field :fax, :type => String
  field :email, :type => String
end
