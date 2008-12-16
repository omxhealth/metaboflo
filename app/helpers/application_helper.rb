# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  VOLUME_UNITS = [ 'mL', 'L' ]
  WEIGHT_UNITS = [ 'g' ]
  CONCENTRATION_UNITS = [ 'mol/L' ]
  CLINICAL_UNITS = ['mg/dL', 'mg/L', 'mEq/L', 'g/dL', 'per cubic mm', 'g/L', 'mcg/mL', 'mmol/L']
  
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
  
end
