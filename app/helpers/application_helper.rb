module ApplicationHelper
  def unescape_quotes(string)
    string.gsub('\&quot;', '"').html_safe
  end
end
