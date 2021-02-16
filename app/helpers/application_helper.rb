module ApplicationHelper
  # Make navbar links have the 'active' class if the current controller matches it
  def nav_active(name)
    controller.controller_name == name ? 'nav-link active' : 'nav-link'
  end

  def markdown(content)
    Kramdown::Document.new(sanitize content, tags: %w()).to_html.html_safe
  end
end
