module ApplicationHelper
  def badge_link_to(items, label, link)
    badge = "<span class='badge badge-info'>#{items.count}</span>"
    link_to "#{label} #{badge}".html_safe, link
  end
end
