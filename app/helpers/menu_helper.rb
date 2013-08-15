module MenuHelper
  def link(label, path, link_controller=nil)
    link_controller ||= send("#{label.downcase}_path")
    active = controller.controller_name == link_controller
    css    = active ? "active" : ""

    content_tag(:li, class: css) do
      link_to label, path
    end
  end

  def admin_link(label, path)
    link label, path, send("admin_#{label.downcase}_path").split("/").last
  end

  def dashboard_link
    link 'Dashboard', dashboard_path, 'dashboards'
  end
end
