# <div>
#  <input type="checkbox" class="filled-in" id="filled-in-box" checked="checked" />
#  <label for="filled-in-box">Filled in</label>
# <div>
#
# <label class="custom-control custom-checkbox">
#   <input type="checkbox" class="custom-control-input">
#   <span class="custom-control-label">Remember me</span>
# </label>
class CheckboxTablerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:label, {class: 'custom-control custom-checkbox'}) do
      template.concat @builder.check_box(attribute_name, {class: 'custom-control-input'})
      template.concat span_tag
    end
  end

  def span_tag
    options[:field_name] ||= object.class.human_attribute_name(attribute_name)

    template.content_tag(:span,  {class: 'custom-control-label'}) do
      options[:field_name]
    end
  end

  def label(wrapper_options)
    ''
  end
end

#  def input(wrapper_options)
#    template.content_tag(:p, {class: 'checkbox-wrapper'}) do
#      template.concat @builder.check_box(attribute_name, {class: 'filled-in'})
#      template.concat @builder.label(attribute_name)
#    end
#  end

