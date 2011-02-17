class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  references_many :items, :default_order => :created_at.desc
  embeds_one :information
  embeds_one :bank_account
  after_create do
    create_information && create_bank_account
  end
end
