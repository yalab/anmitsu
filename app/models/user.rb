class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  embeds_one :base_info
  after_create do
    create_base_info
  end
end
