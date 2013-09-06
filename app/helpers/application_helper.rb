module ApplicationHelper
  def badge_link_to(items, label, link)
    badge = "<span class='badge badge-info'>#{items.count}</span>"
    link_to "#{label} #{badge}".html_safe, link
  end

  def link_to_remove_fields(name, f, options = {})
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", options)
  end

  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{ association }") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    link_to_function(name, "add_fields(this, \"#{ association }\", \"#{ escape_javascript(fields) }\")", options)
  end

  def format_date(date)
    date.strftime("%b %d, %Y")
  end

  def format_datetime(date)
    date.strftime("%b %d, %Y %I:%M%P")
  end

  def localized(collection)
    if block_given?
      collection.each { |item| yield(item.localized) }
    else
      collection.map { |item| item.localized }
    end
  end

  def current_page
    "#{controller.controller_name}_#{controller.action_name}".camelize
  end
end
