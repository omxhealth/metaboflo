# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  VOLUME_UNITS = [ 'mL', 'L' ]
  WEIGHT_UNITS = [ 'g' ]
  CONCENTRATION_UNITS = [ 'mol/L' ]
  CLINICAL_UNITS = ['mg/dL', 'mg/L', 'mEq/L', 'g/dL', 'per cubic mm', 'g/L', 'mcg/mL', 'mmol/L']
  
  require 'tabular_form_builder'
  
  def array_to_table(array, columns, options = {})
    options[:table_parameters] ||= ""
    out = "<table #{options[:table_parameters]}>"
    i = 1
    array.each do |e|
      out << "<tr>" if i == 0
      out << "<td>#{e}</td>"
      if i == columns
        out << "</tr>" 
        i = 0
      end
      i += 1
    end
    if out =~ /<\/tr>$/
      out << "</table>"
    else
      out << "</tr></table"
    end
  end
    
  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_for :jstemplates do
        content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
          form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|        
            render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })        
          end
        end
      end
  end
  
  # def remove_link_unless_new_record(fields)
  #   if fields.object.persisted?     
  #     out = ''
  #     out << fields.check_box(:_destroy)
  #     out << fields.label( :_destroy, "Destroy")
  #     out.html_safe
  #   end
  # end
  
  def add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child button", :"data-association" => association)
  end

  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child button")
  end
  
  # Set the given title for the current page. Returns the given title so you can use it in your
  # page as a header, for example: <h1><%= title('Welcome') %></h1>
  def title(page_title)
    content_for(:title) { strip_tags(page_title.to_s) }
    page_title.html_safe
  end
  
  def date_picker(id)
    javascript_tag do
      "$(function() { $('##{id}').datepicker(); });"
    end.html_safe
	end
	
  def error_message(attribute, errors)
    "<span class=\"field-error\">#{attribute} #{errors.first}</span>".html_safe unless errors.empty?
  end
  
  def required
    '<span class="required">*</span>'
  end
    
  def unit_options
    VOLUME_UNITS.concat(WEIGHT_UNITS).concat(CONCENTRATION_UNITS).sort
  end

  def volume_unit_options
    VOLUME_UNITS
  end

  def weight_unit_options
    WEIGHT_UNITS.sort
  end

  def concentration_unit_options
    CONCENTRATION_UNITS.sort
  end
  
  def clinical_unit_options
    CLINICAL_UNITS.sort
  end
  
  def boolean_to_english(val)
    if val == true
      return 'yes'
    else
      return 'no'
    end
  end
  
  def destroy_link(params)
    link_to('delete', params, {:confirm => 'Are you sure you want to delete this entry?', :method => :delete, :class => 'icon icon-del', :title => 'Delete Entry'} )
  end
  
  def edit_link(params)
    link_to('edit', params, :class => 'icon icon-edit', :title => 'Edit Entry' )
  end
  
  def show_link(params, name='show')
    link_to(name, params, :class => 'icon icon-show', :title => 'Show Entry' )
  end
  
  def new_link(name, params)
    name ||= 'new'
    link_to(name, params, :class => 'icon icon-add' )
  end
     
  # association
  def add_link_for_new_fields_for(form_builder, model_name)
    association = model_name.to_s.underscore.pluralize
    function = ''
    form_builder.fields_for(association.to_sym, model_name.to_s.camelize.constantize.new, :child_index => 'NEW_RECORD') do |f|
      html = render(:partial => model_name.to_s.underscore, :locals => { :f => f })
      function << "$('##{association}').append('#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime())); if( $('##{association}').css('display') == 'none' ) { $('##{association}').toggle('blind'); }"
    end

    link_to_function "Add #{model_name.to_s.underscore.humanize.downcase}", function
  end
  
  def new_child_fields(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  # Display the remove link for a child form
  def remove_fields_for(form_builder, model_name)
    if form_builder.object.new_record?
      # If the object is a new record, we can just remove the div from the dom
      link_to_function('Remove', "$(this).parent('.fields').remove();")
    else
      # However if it's a "real" record it has to be deleted from the database,
      # for this reason the new fields_for, accepts_nested_attributes_for helpers give us _delete,
      # a virtual attribute that tells rails to delete the child record
      form_builder.hidden_field(:_destroy) +
      link_to_function('Remove', "$(this).parent('.fields').fade(); $(this).siblings(':last').val('1')")
    end
  end
end
