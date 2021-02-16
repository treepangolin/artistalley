module ApplicationHelper
  # Make navbar links have the 'active' class if the current controller matches it
  def nav_active(name)
    controller.controller_name == name ? 'nav-link active' : 'nav-link'
  end

  def markdown(content)
    options = {
        filter_html: true,
        hard_wrap: true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true,
        fenced_code_blocks: true
    }

    extensions = {
        autolink: true,
        superscript: true,
        disable_indented_code_blocks: true
    }

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(options), extensions)

    markdown.render(content).html_safe
  end
end
