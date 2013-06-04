class BankAccount < ActiveRecord::Base
  belongs_to :user
  TYPE = [:normal, :current]
end
