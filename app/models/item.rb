class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  include Stateflow
  paginates_per 10
  TAX = 5
  field :title,         :type => String
  field :description,   :type => String
  field :note,          :type => String
  field :client_name,   :type => String
  field :state,         :type => String
  field :estimated_at,  :type => Time, :default => Time.now
  field :ordered_at,    :type => Time
  field :deliveried_at, :type => Time
  field :receipted_at,  :type => Time
  field :created_at,    :type => Time
  referenced_in :user
  embeds_many :accounts
  validates :title, :presence => true

  scope :title_or_client, lambda{|title|
    break scoped if title.blank?
    regexp = Regexp.compile(Regexp.quote(title))
    any_of({:client_name => regexp}, {:title => regexp})
  }

  scope :state_is, lambda{|state|
    (state.blank?) ? scoped : where(:state => state)
  }

  scope :client_name_like, lambda{|name|
    (name.blank?) ? scoped : where(:client_name => Regexp.compile(Regexp.quote(name)))
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
end
