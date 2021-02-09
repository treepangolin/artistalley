module ApplicationHelper
  def nav_active(name)
    controller.controller_name == name ? 'nav-link active' : 'nav-link'
  end
end
