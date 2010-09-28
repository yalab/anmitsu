class Account
  include Mongoid::Document
  field(:content, :type => String)  || validates(:content, :presence => true)
  field(:price,   :type => Integer) || validates(:price,   :presence => true)
  field(:note,    :type => String)  || nil
  embedded_in :estimation, :inverse_of => :accounts

  def accounts_url

  end
end
