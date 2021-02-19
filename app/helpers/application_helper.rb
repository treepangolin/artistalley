module ApplicationHelper
  # Make navbar links have the 'active' class if the current controller matches it
  def nav_active(path)
    current_page?(path) ? 'active' : ''
  end

  def markdown(content)
    Kramdown::Document.new(sanitize(content, tags: %w[])).to_html.html_safe
  end
end
