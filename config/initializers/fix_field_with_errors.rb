# This fix uses a span instead of a div tag for wrapping fields that 
# have been marked as an error.  The div tag is not an inline tag, 
# and setting display:inline has a bug in Safari.

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|
"<span class=\"fieldWithErrors\">#{html_tag}</span>" }