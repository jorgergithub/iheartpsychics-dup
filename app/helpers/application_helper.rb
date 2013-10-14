module ApplicationHelper
  def badge_link_to(items, label, link)
    badge = "<span class='badge badge-info'>#{items.count}</span>"
    link_to "#{label} #{badge}".html_safe, link
  end

  def link_to_remove_fields(name, f, options = {})
    function = options.delete(:function) || "remove_fields"
    f.hidden_field(:_destroy) + link_to_function(name, "#{function}(this)", options)
  end

  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{ association }") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end

    element_finder = ""
    if element_finder = options.delete(:element_finder)
      element_finder = ", #{element_finder}"
    end

    link_to_function(name, "add_fields(this,
      \"#{ association }\",
      \"#{ escape_javascript(fields) }\"#{element_finder})", options)
  end

  def template_for_field(f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{ association }") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
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
    if admin_controller?
      "admin_#{controller.controller_name}_#{action_name}".camelize
    else
      "#{controller.controller_name}_#{action_name}".camelize
    end
  end

  def provider_name(provider)
    if provider == :google_oauth2
      provider = :google
    end

    provider.to_s.titleize
  end

  private

  def admin_controller?
    controller.class.name.split("::").first == "Admin"
  end

  def action_name
    case controller.action_name
    when "new", "create"
      "new"
    when "edit", "update"
      "update"
    else
      controller.action_name
    end
  end
end
