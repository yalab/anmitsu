class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Stateflow
  TAX = 0.5
  [:title, :description, :note, :client_name, :state].each{|name| field name, :type => String }
  [:created_at].each{|name| field name, :type => Time }
  referenced_in :user
  embeds_many :accounts
  validates :title, :presence => true

  stateflow do
    state :estimate, :order, :delivery, :receipt
    initial :estimate
  end

  def total
    accounts.map{|account| account.price }.inject(:+)
  end
  def total_with_tax
    (total * TAX).truncate
  end
end
