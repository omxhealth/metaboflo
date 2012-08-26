# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  VOLUME_UNITS = [ 'mL', 'L' ]
  WEIGHT_UNITS = [ 'g' ]
  CONCENTRATION_UNITS = [ 'mol/L' ]
  CLINICAL_UNITS = ['mg/dL', 'mg/L', 'mEq/L', 'g/dL', 'per cubic mm', 'g/L', 'mcg/mL', 'mmol/L']
  
  # Set the given title for the current page. Returns the given title so you can use it in your
  # page as a header, for example: <h1><%= title('Welcome') %></h1>
  def title(page_title)
    content_for(:title) { strip_tags(page_title.to_s) }
    page_title.html_safe
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
end
