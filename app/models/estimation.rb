class Estimation
  include Mongoid::Document
  field :title, :type => String
  field :description, :type => String
  field :note, :type => String
  field :client_name, :type => String
  embeds_many :accounts
end
