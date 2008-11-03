# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def boolean_to_english(val)
    if val == true
      return 'yes'
    else
      return 'no'
    end
  end
  
  
end
