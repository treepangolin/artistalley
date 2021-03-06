module ApplicationHelper
  # Make navbar links have the 'active' class if the current controller matches it
  def nav_active(path)
    current_page?(path) ? 'active' : ''
  end

  def markdown(content)
    Kramdown::Document.new(sanitize(content, tags: %w[])).to_html.html_safe
  end

  def time_since_created(object, long: false)
    if object.created_at < 7.days.ago
      object.created_at.strftime(long ? '%B %d, %Y' : '%d %b, %Y')
    else
      "#{time_ago_in_words(object.created_at)} ago"
    end
  end
end
