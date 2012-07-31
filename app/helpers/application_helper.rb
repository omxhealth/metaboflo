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
  
  def short_description(str, max_length = 50)
    if (str and
        str.length > max_length)
      "#{str[0..max_length]}..."
    else
      str
    end
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
  
  def labelled_tabular_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    options[:html] ||= {}
    options[:html][:class] = 'tabular' unless options[:html].has_key?(:class)
    form_for(record_or_name_or_array, options.merge({ :builder => TabularFormBuilder }), &proc)
  end
  
  # Create a link to external sites based on the given object and column.  If a name is given,
  # it will be used as the link content (<a href="x">name</a>")
  def link_out_old(object, column, name=nil, html_options={})
    html_options[:class] = 'link-out' if html_options[:class].blank?
    html_options[:target] = '_blank' if html_options[:target].blank?

    id = "#{object.send(column).to_s}"
    return '' if id.blank?
    name = "#{id}" if name.blank?

    url = case column.to_sym
      when :pubchem_compound_id then "http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid=" << id
      when :chebi_id            then "http://www.ebi.ac.uk/chebi/searchId.do?chebiId=" << id
      when :pubmed_id           then "http://www.ncbi.nlm.nih.gov/pubmed/#{id}"                    
      when :hmdb_id             then "http://hmdb.ca/metabolites/#{id}"
      when :cas                 then "http://www.nlm.nih.gov/cgi/mesh/2006/MB_cgi?rn=1&term=#{id}"
      when :kegg_compound_id    then "http://www.genome.jp/dbget-bin/www_bget?cpd:" << id   
      when :wikipedia_name      then "http://en.wikipedia.org/wiki/" << id   
      else                      nil
    end
    return id if url.blank?

    name << " " << image_tag('link_out.png', :class => 'link')
    return link_to(name.html_safe, url, html_options)
  end
  
  # association
  def add_link_for_new_fields_for(form_builder, model_name)
    association = model_name.to_s.underscore.pluralize
    link_to_function "Add #{model_name.to_s.underscore.humanize.downcase}" do |page|
      form_builder.fields_for(association.to_sym, model_name.to_s.camelize.constantize.new, :child_index => 'NEW_RECORD') do |f|
        html = render(:partial => model_name.to_s.underscore, :locals => { :f => f })
        page << "$('##{association}').append('#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime())); if( $('##{association}').css('display') == 'none' ) { $('##{association}').toggle('blind'); }"
      end
    end
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
