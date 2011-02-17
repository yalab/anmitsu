class Account
  include Mongoid::Document
  field(:content, :type => String)  || validates(:content, :presence => true)
  field(:price,   :type => Integer) || validates(:price,   :presence => true, :numericality => {:only_integer => true})

  field(:note,    :type => String)  || nil
  embedded_in :item, :inverse_of => :accounts

  def serializable_hash(*args)
    hash = super
    hash[:item_total] = item.total
    hash[:item_total_with_tax] = item.total_with_tax
    hash
  end
end
