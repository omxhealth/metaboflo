# redMine - project management software
# Copyright (C) 2006-2007  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'action_view/helpers/form_helper'

class TabularFormBuilder < ActionView::Helpers::FormBuilder
  def initialize(object_name, object, template, options, proc)
    super
  end      
      
  (field_helpers - %w(radio_button hidden_field label) + %w(date_select datetime_select)).each do |selector|
    src = <<-END_SRC
    def #{selector}(field, options = {}) 
      return super.html_safe if options.delete :no_label
      label_text = options[:label] if options[:label]
      label_text ||= field.to_s.gsub(/\_id$/, "").humanize
      label_text << @template.content_tag("span", " *", :class => "required") if options.delete(:required)
      label = self.label(field, label_text.html_safe)
      # label = @template.content_tag("label", label_text, 
      #               :class => (@object && @object.errors[field] ? "error" : nil), 
      #               :for => (@object_name.to_s + "_" + field.to_s))
      (label + super).html_safe
    end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end
  
  def class
    'Form'
  end
  
  def select(field, choices, options = {}, html_options = {}) 
    return super.html_safe if options.delete :no_label
    label_text = options[:label] if options[:label]
    label_text ||= field.to_s.gsub(/\_id$/, "").humanize + (options.delete(:required) ? @template.content_tag("span", " *", :class => "required"): "")
    label = self.label(field, label_text.html_safe)
    # label = @template.content_tag("label", label_text, 
    #               :class => (@object && @object.errors[field] ? "error" : nil), 
    #               :for => (@object_name.to_s + "_" + field.to_s))
    (label + super).html_safe
  end

  def country_select(field, priority_countries = nil, options = {}, html_options = {}) 
    return super.html_safe if options.delete :no_label
    label_text = options[:label] if options[:label]
    label_text ||= field.to_s.gsub(/\_id$/, "").humanize + (options.delete(:required) ? @template.content_tag("span", " *", :class => "required"): "")
    label = self.label(field, label_text.html_safe)
    # label = @template.content_tag("label", label_text, 
    #               :class => (@object && @object.errors[field] ? "error" : nil), 
    #               :for => (@object_name.to_s + "_" + field.to_s))
    (label + super).html_safe
  end
  
  def check_box_group(field, choices, options= {}, html_option = {})
    count = 0
    options[:per_row] ||= 5
    checked_choices = @object.send(field)
    
    out = '<table class="checkbox-group"><tr>'
    choices.each do |c|
      if count % options[:per_row] == 0 && count != 0
        out += "</tr><tr>"
      end
      count += 1

      id = "#{@object_name}_#{field}_#{count}"

      checkbox_tag = String.new
      checkbox_tag << @template.check_box_tag( "#{@object_name}[#{field}][]", c, checked_choices.include?(c), :id => id) << " "
      checkbox_tag << @template.label_tag(id, c, :class => 'grouped')

      out += @template.content_tag("td", checkbox_tag)
    end
    out += "</tr></table>"
  end
end
