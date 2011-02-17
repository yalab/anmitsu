module ApplicationHelper
  def format_time(time, format='default')
    time.strftime(t("time.formats.#{format}"))
  end

  def paginate(collection)
    will_paginate(collection, :next_label => t('Next page'), :previous_label => t('Previous page'))
  end
end
