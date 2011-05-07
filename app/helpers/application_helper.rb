# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  VOLUME_UNITS = [ 'mL', 'L' ]
  WEIGHT_UNITS = [ 'g' ]
  CONCENTRATION_UNITS = [ 'mol/L' ]
  CLINICAL_UNITS = ['mg/dL', 'mg/L', 'mEq/L', 'g/dL', 'per cubic mm', 'g/L', 'mcg/mL', 'mmol/L']
  
  require 'tabular_form_builder'
  
  def unit_options
    VOLUME_UNITS.concat(WEIGHT_UNITS).concat(CONCENTRATION_UNITS).sort
  end

  def volume_unit_options
    VOLUME_UNITS.sort
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
    return link_to('Delete', params, {:confirm => 'Are you sure?', :method => :delete, :class => 'icon icon-del'} )
  end
  
  def edit_link(params)
    return link_to('Edit', params, :class => 'icon icon-edit' )
  end
  
  def show_link(params)
    return link_to('Show', params, :class => 'icon icon-show' )
  end
  
  def new_link(name, params)
    return link_to("New #{name}", params, :class => 'icon icon-add' )
  end
  
  def labelled_tabular_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    options[:html] ||= {}
    options[:html][:class] = 'tabular' unless options[:html].has_key?(:class)
    form_for(record_or_name_or_array, options.merge({ :builder => TabularFormBuilder }), &proc)
  end
  
  # Create a link to external sites based on the given object and column.  If a name is given,
  # it will be used as the link content (<a href="x">name</a>")
  def link_out(object, column, name=nil, html_options={})
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
    return link_to(name, url, html_options)
  end
  
end
