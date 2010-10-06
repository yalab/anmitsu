class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  references_many :estimations
  embeds_one :base_info
  embeds_one :bank_account
  after_create do
    create_base_info && create_bank_account
  end
end
