class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :items
  has_one :information
  has_one :bank_account
  after_create do
    create_information && create_bank_account
  end

  def beginner?
    information.name.nil? || information.name.length < 1
  end
end
