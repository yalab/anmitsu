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
    @total ||= accounts.map(&:price).inject(:+)
  end

  def total_with_tax
    @totel ||= ((total * (100 + TAX)) / 100).truncate
  end
end
