class BankAccount
  include Mongoid::Document
  field :bank_name,   :type => String
  field :branch_name, :type => String
  field :name,        :type => String
  field :code,        :type => String
  embedded_in :user, :inverse_of => :bank_account
end
