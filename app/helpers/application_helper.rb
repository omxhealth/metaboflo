# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  VOLUME_UNITS = [ 'mL', 'L' ].freeze
  WEIGHT_UNITS = [ 'g' ].freeze
  CONCENTRATION_UNITS = [ 'mol/L' ].freeze
  CLINICAL_UNITS = ['mg/dL', 'mg/L', 'mEq/L', 'g/dL', 'per cubic mm', 'g/L', 'mcg/mL', 'mmol/L'].freeze

  # Accepts a title for a page - to be yielded in a template layout
  def title(page_title)
    content_for(:title) { strip_tags(page_title.to_s).html_safe }
    page_title.html_safe
  end

  # Used in the header section of the site
  def site_title(title=nil)
    if title.present?
      "#{title} - Metaboflo"
    else
      'Metaboflo'
    end
  end

  # Return an icon from bootstrap 3
  def glyphicon(kind)
    content_tag(:span, ' ', class: "glyphicon glyphicon-#{kind.to_s.dasherize}")
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
