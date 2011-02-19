class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Stateflow
  TAX = 5
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
    @total ||= (accounts.length > 0) ? accounts.map(&:price).inject(:+) : 0
  end


  def tax
    @tax ||= total * TAX / 100
  end

  def total_with_tax
    @totel ||= tax + total
  end
end
