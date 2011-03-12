module ApplicationHelper
  def format_time(time, format='default')
    time.strftime(t("time.formats.#{format}"))
  end
end
