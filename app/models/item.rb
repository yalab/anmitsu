class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Stateflow
  [:title, :description, :note, :client_name, :state, :expire].each{|name| field name, :type => String }
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
end
