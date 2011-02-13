class Account
  include Mongoid::Document
  field(:content, :type => String)  || validates(:content, :presence => true)
  field(:price,   :type => Integer) || validates(:price,   :presence => true)
  field(:note,    :type => String)  || nil
  embedded_in :item, :inverse_of => :accounts
end
