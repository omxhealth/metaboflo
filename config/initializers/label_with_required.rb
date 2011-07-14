module ActionView
  module Helpers
    module FormTagHelper
      def label_tag_with_required(name = nil, content_or_options = nil, options = nil, &block)
        content_or_options = name.to_s.humanize if content_or_options.nil?
        content_or_options += content_tag(:span, " *", :class => "required") if options.is_a?(Hash) && options.delete("required")
        label_tag_without_required(name, content_or_options.html_safe, options, &block)
      end
      alias_method_chain :label_tag, :required
    end
  end
end
