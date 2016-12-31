module FormHelper
  def knoxy_form_for(object, *args, &block)
    options = args.extract_options!
    options[:html] ||= {}
    options[:html][:class] = 'standard' unless options[:html].has_key?(:class)

    simple_form_for(object, *(args << options.merge(builder: KnoxyFormBuilder)), &block)
  end

  def form_header(title)
    content_tag(:legend, title, id: title.parameterize('_'))
  end

  def render_form_errors(entry)
    render '/shared/form_errors', entry: entry
  end

  #
  # Support methods for nested forms
  #
  # Generate the form template that will be used when the user adds a new element.
  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association.to_sym).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
      end
    end
  end

  def my_add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
  end

  def my_remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
  end

  def add_child_link(form_builder, association, options = {})
    options[:name] ||= "Add #{association.to_s.titleize.singularize}"
    adder = content_tag(:div, :class => "nested-add") do
      content_tag(:div, link_to(options[:name], "javascript:void(0)", :class => "add_child nested-add-#{association.to_s.dasherize}", :"data-association" => association), :class => 'nested-add-holder actions') <<
      new_child_fields_template(form_builder, association, options)
    end
  end

  def remove_child_link(name, f, html_options = {})
    html_options[:class] ||= ''
    html_options[:class] << 'remove_child'
    remover = content_tag(:div, :class => "nested-remove actions") do
      f.hidden_field(:_destroy) + link_to(name.to_s, "javascript:void(0)", html_options)
    end
  end
end
