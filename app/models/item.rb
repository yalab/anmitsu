class Item < ActiveRecord::Base
  include Stateflow
  paginates_per 10
  TAX = 5
  belongs_to :user
  has_many :accounts
  validates :title, :presence => true
  before_create :set_default_values

  scope :title_or_client, lambda{|title|
    return scoped if title.blank?
    where("client_name like ? OR title like ?", "%#{title}%", "%#{title}%")
  }

  scope :state_is, lambda{|state|
    (state.blank?) ? scoped : where(:state => state)
  }

  stateflow do
    state :estimate, :order, :delivery, :receipt, :reject
    all_state = states.keys
    initial :estimate
    {:order    => :ordered_at,
     :delivery => :deliveried_at,
     :receipt  => :receipted_at}.each do |st, time|
      state st do
        enter lambda{|i| i.send("#{time}=", Time.now) }
      end
      event st do
        transitions :from => all_state - [st], :to => st
      end
    end
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

  private
  def set_default_values
    self.estimated_at ||= Time.now
  end
end
