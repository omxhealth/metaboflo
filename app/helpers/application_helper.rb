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

  # Return the "Not Available" tag when the given value is blank.
  # Optionally pass in a message to use instead of "Not Available".
  # Return the given value if it is not blank.
  def nah(value=nil, message="Not Available")
    if value.present?
      value.respond_to?(:html_safe) ? value.html_safe : value
    else
      "<span class='text text-muted'>#{message}</span>".html_safe
    end
  end


  def destroy_link(params, title='delete')
    link_to "#{icon(:remove)} #{title}".html_safe, params,
      data: { confirm: 'Are you sure you want to delete this entry?' },
      method: :delete, class: 'btn btn-outline-danger btn-sm',
      title: 'Delete Entry'
  end

  def edit_link(params, title='edit')
    link_to "#{icon(:edit)} #{title}".html_safe, params,
      class: 'btn btn-sm btn-outline-primary', title: 'Edit Entry'
  end

  def show_link(params, title='view')
    link_to "#{icon(:eye)} #{title}".html_safe, params,
      class: 'btn btn-sm btn-outline-primary', title: 'Show Entry'
  end

  def new_link(title, params)
    title ||= 'new'
    link_to "#{icon(:'plus-square')} add #{title}".html_safe, params, class: 'btn btn-sm btn-outline-success'
  end

  def table_search_actions
    content_tag(:div, class: 'table-search-actions btn-group') do
      button_tag(icon(:search), type: 'submit', class: 'btn btn-info btn-sm') <<
      link_to('clear', request.path, class: 'btn btn-secondary btn-sm')
    end
  end

  def table_search_text(form, query, *args)
    options = args.extract_options!
    if options[:class].present? && options[:class].is_a?(String)
      options[:class] = [options[:class]]
    end
    options[:class] ||= []
    options[:class].concat(["form-control", "input-tbl-search"])

    form.text_field query, *(args << options)
  end

  def table_search_select(form, field, select_options, options={}, *args)
    options[:include_blank] ||= true
    html_options = args.extract_options!
    if html_options[:class].present? && html_options[:class].is_a?(String)
      html_options[:class] = [html_options[:class]]
    end
    html_options[:class] ||= []
    html_options[:class].concat(["form-control", "input-tbl-search"])

    form.select field,
      select_options,
      options,
      *(args << html_options)
  end
end
