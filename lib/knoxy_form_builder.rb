require 'action_view/helpers/form_helper'

class KnoxyFormBuilder < ActionView::Helpers::FormBuilder
  def initialize(object_name, object, template, options, proc)
    super
  end      

  # <div class="field-holder">
  #   <div class="left-label">
  #     <%= f.label :drugbank_id, 'DrugBank ID' %>
  #   </div>
  #   <div class="field">
  #     <%= f.text_field :drugbank_id, :disabled => true %>
  #   </div>
  # </div>

  (field_helpers - %w(radio_button hidden_field label fields_for) + %w(date_select datetime_select)).each do |selector|
    src = <<-END_SRC
    def #{selector}(field, options = {}) 
      return super if options.delete(:inner)
      error_msg = options.delete(:error_msg)
      full_field = @template.content_tag(:div, :class => 'field-holder', :"data-validate" => error_msg, :id => field.to_s.clone << "-knoxy-field") do
        input_field = label_for_field(field, options)
        input_field << @template.content_tag(:div, :class => "field") do
          super
        end.html_safe
        input_field.html_safe
      end
      full_field.html_safe
    end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end

  def class
    'Form'
  end

  def inner_field(field, options = {})
    full_field = @template.content_tag(:div, :class => 'field-holder') do
      input_field = String.new
      input_field << @template.content_tag(:div, :class => "left-label") do
        label_text = options.delete(:label)
        if label_text.present?
          self.label(field, label_text)
        else
          self.label(field)
        end
      end.html_safe
      
      input_field << @template.content_tag(:div, :class => "field") do
        yield
      end.html_safe
      input_field.html_safe
    end
    full_field.html_safe
  end

  def inner_field_group(field, options = {})
    full_field = @template.content_tag(:div, :class => 'field-holder') do
      input_field = String.new
      input_field << @template.content_tag(:div, :class => "left-label") do
        label_text = options.delete(:label)
        if label_text.present?
          self.label(field, label_text)
        else
          self.label(field)
        end
      end.html_safe

      input_field << @template.content_tag(:div, :class => "field inner-group-field") do
        @template.content_tag(:div, :class => "inner-group") do
          yield
        end.html_safe
      end.html_safe
      input_field.html_safe
    end
    full_field.html_safe
  end
  
  # Grouping that includes a label on the left, and right fields where the contents are inline. 
  # Cannot contain nested fields, only simple form elements, links, hints, etc.
  def inline_field_group(field, options = {})
    @template.content_tag(:div, :class => 'field-holder') do
      group = String.new

      # Add the left label
      group << @template.content_tag(:div, :class => "left-label inline-item-label") do
        label_text = options.delete(:label)
        label_text.present? ? self.label(field, label_text) : self.label(field)
      end.html_safe

      # Yield to create the inline left content
      group << @template.content_tag(:div, :class => "field inline-item") do
        yield self
      end.html_safe

      # Return the left and right fields
      group.html_safe
    end.html_safe
  end

  def full_field_group(field, options = {})
    full_field = @template.content_tag(:div, :class => 'field-holder') do
      input_field = String.new
      input_field << @template.content_tag(:div, :class => "field full-group-field") do
        @template.content_tag(:div, :class => "full-group") do
          yield
        end.html_safe
      end.html_safe
      input_field.html_safe
    end
    full_field.html_safe
  end
  
  def group_item(field, options = {})
    full_field = @template.content_tag(:div, :class => 'group-item-holder') do
      input_field = String.new
      input_field << @template.content_tag(:div, :class => "left-label group-item-label") do
        label_text = options.delete(:label)
        if label_text.present?
          self.label(field, label_text)
        else
          self.label(field)
        end
      end.html_safe

      input_field << @template.content_tag(:div, :class => "field group-item") do
        yield
      end.html_safe
      input_field.html_safe
    end
    full_field.html_safe
  end

  def textile_editor(field, options = {}) 
    if options[:class].present?
      options[:class] << ' textile-editor'
    else 
      options[:class] = 'textile-editor'
    end
    options[:placeholder] = 'Insert text in Textile format'
    help_link = @template.link_to('Textile Reference', 'http://redcloth.org/hobix.com/textile/quick.html', :target => '_blank')
    hint = @template.content_tag(:div, help_link, :class => 'textile-hint')
    return hint + self.text_area(field, options) if options[:inner].present?

    label_option = options.delete(:label)
    label_text = if label_option.present?
      self.label(field, label_text)
    else
      self.label(field)
    end
    options[:label] = label_text.html_safe
    @template.content_tag(:div, (hint + self.text_area(field, options)), :class => 'textile-holder')
  end

  def select(field, choices, options = {}, html_options = {})
    return super if options.delete(:inner)
    full_field = @template.content_tag(:div, :class => 'field-holder') do
      input_field = String.new
      input_field << label_for_field(field, options)
      input_field << @template.content_tag(:div, :class => "field") do
        super
      end.html_safe
      input_field.html_safe
    end
    full_field.html_safe
  end
  
  def check_box_group(field, choices, options= {}, html_option = {})
    count = 0
    options[:per_row] ||= 5
    checked_choices = @object.send(field)
    
    out = '<table class="checkbox-group"><tr>'.html_safe
    choices.each do |c|
      if count % options[:per_row] == 0 && count != 0
        out += "</tr><tr>".html_safe
      end
      count += 1

      id = "#{@object_name}_#{field}_#{count}".html_safe

      checkbox_tag = String.new.html_safe
      checkbox_tag << @template.check_box_tag( "#{@object_name}[#{field}][]", c, checked_choices.include?(c), :id => id).html_safe << " ".html_safe
      checkbox_tag << @template.label_tag(id, c, :class => 'grouped').html_safe

      out += @template.content_tag("td", checkbox_tag).html_safe
    end
    out += "</tr></table>".html_safe
    out.html_safe
  end

  # def country_select(field, priority_countries = nil, options = {}, html_options = {}) 
  #   return super.html_safe if options.delete :no_label
  #   label_text = options[:label] if options[:label]
  #   label_text ||= field.to_s.gsub(/\_id$/, "").humanize + (options.delete(:required) ? @template.content_tag("span", " *", :class => "required"): "")
  #   label = self.label(field, label_text.html_safe)
  #   # label = @template.content_tag("label", label_text, 
  #   #               :class => (@object && @object.errors[field] ? "error" : nil), 
  #   #               :for => (@object_name.to_s + "_" + field.to_s))
  #   (label + super).html_safe
  # end

  private 
  def label_for_field(field, options)
    if options.has_key?(:label) && options[:label].present? # Label is either a string or false
      @template.content_tag( :div, self.label(field, options[:label]), :class => "left-label" )
    elsif !options.has_key?(:label) # No label provided, use default  
      @template.content_tag( :div, self.label(field), :class => "left-label" )
    else
      ''
    end
  end

  # 
  # def label(method, text=nil, options = {})
  #   text << @template.content_tag("span", "&nbsp;*".html_safe, :class => "required") if options.delete(:required)
  #   options[:class] = options[:class].blank? ? 'tabbed' : "#{options[:class]} tabbed"
  #   super(method, text.to_s.html_safe, options)
  # end
end

