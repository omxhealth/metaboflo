# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

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
  
end
