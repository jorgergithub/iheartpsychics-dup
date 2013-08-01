module FormHelper
  def add_field(form, field_name, label=nil, options={})
    content_tag(:div, class: "control-group") do
      result = form.label field_name, label, class: "control-label"
      result << content_tag(:div, class: "controls") do
        yield
      end
      result.html_safe
    end
  end

  def add_text_field(form, field_name, label=nil, options={})
    add_field(form, field_name, label, options) do
      form.text_field(field_name, options).html_safe
    end
  end

  def add_text_area(form, field_name, label=nil, options={})
    add_field(form, field_name, label, options) do
      form.text_area(field_name, options).html_safe
    end
  end

  def add_password_field(form, field_name, label=nil, options={})
    add_field(form, field_name, label, options) do
      form.password_field(field_name, options).html_safe
    end
  end

  def add_yesno_field(form, field_name, label=nil, options={})
    add_field(form, field_name, label, options) do
      result = content_tag(:label, class: "radio") do
        r =  form.radio_button field_name, "true"
        r << "Yes"
      end
      result << content_tag(:label, class: "radio") do
        r =  form.radio_button field_name, "false"
        r << "No"
      end
    end
  end
end
