module FormHelper
  def knoxy_form_for(*args, &proc)
    options = args.extract_options!
    options[:html] ||= {}
    options[:html][:class] = 'standard' unless options[:html].has_key?(:class)
    args << options.merge({ :builder => KnoxyFormBuilder })
    form_for(*args, &proc)
  end
  
  def form_header(title)
    id = title.gsub(/\W/, '_').downcase
    "<legend id=\"#{id}\">#{title}</legend>".html_safe
  end
  
  def show_header(title, object, colspan=2)
    name = title.gsub(/\W/, '_').downcase
    head = "<tr><th id=\"#{name}\"class=\"spanheader\" colspan=\"#{colspan}\">#{title} " << link_to('[Edit]', :id => object.to_param, :action => 'edit', :anchor => name) << "</th></tr>"
    head.html_safe
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
  
  # Go to the referrer, applying the anchor. Must supply a default URL that is used if the referrer is blank.
  def url_back_with_anchor(default_url, anchor)
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      request.env["HTTP_REFERER"] << "##{anchor}"
    else
      default_url << "##{anchor}"
    end
  end
  
  # Return a <p> containing the given error message if the entity has an activerecord error
  # on the given field. If there are no errors return nil.
  def validation_msg(entity, field, message)
    if entity.errors.include?(field.to_sym)
      content_tag( :p, "* #{message}", :class => 'error-msg' )
    end
  end
  
  def div_field_with_error(entity, field, message)
    content_tag :div, :class => 'field', :id => "#{field}-field", :"data-validate" => message do
      yield
      validation_msg entity, field, message
    end
  end

  def render_form_errors(entry)
    render :partial => '/shared/form_errors', :locals => { :entry => entry }
  end
end
