module ApplicationHelper
  def paginate(collection)
    will_paginate(collection, :next_label => t('Next page'), :previous_label => t('Previous page'))
  end
end
