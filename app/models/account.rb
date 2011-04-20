class Account
  include ActionView::Helpers::NumberHelper
  include Mongoid::Document
  field :content, :type => String
  field :price,   :type => Integer
  validates :content, :presence => true
  validates :price,   :presence => true, :numericality => {:only_integer => true}
  field(:note,    :type => String)  || nil
  embedded_in :item, :inverse_of => :accounts

  def serializable_hash(*args)
    hash = super
    hash[:item_total] = number_with_delimiter(item.total)
    hash[:item_total_with_tax] = number_with_delimiter(item.total_with_tax)
    hash[:item_tax] = number_with_delimiter(item.tax)
    hash[:price] = number_with_delimiter(price)
    hash[:unit] = I18n.t('number.currency.unit')
    hash
  end
end
