class BankAccount
  include Mongoid::Document
  field :bank_name,   :type => String
  field :branch_name, :type => String
  field :branch_number, :type => String
  field :name,        :type => String
  field :code,        :type => String
  field :type,        :type => String
  embedded_in :user, :inverse_of => :bank_account
  TYPE = [:normal, :current]
end
