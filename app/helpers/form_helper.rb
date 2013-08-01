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

  def add_select(form, object, field_name, values, label=nil, options={})
    add_field(form, field_name, label, options) do
      select(object, field_name, values, include_blank: true)
    end
  end

  def add_state_select(form, object, field_name, label=nil, options={})
    add_field(form, field_name, label, options) do
      select(object, field_name, us_states, include_blank: true)
    end
  end

  def add_file_field(form, object, field_name, label=nil, options={})
    add_field(form, field_name, label, options) do
      r = ""
      if object.resume?
        r << content_tag(:div, class: field_name) do
          object.resume.identifier
        end
      end
      r << form.file_field(field_name)
      r << form.hidden_field("#{field_name}_cache")
      r.html_safe
    end.html_safe
  end

  def us_states
      [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY']
      ]
  end
end
