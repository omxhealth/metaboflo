# All links and submit buttons in an .action class element will be turned into jQuery buttons
@init_action_buttons = (context) ->
  context ||= document
  $( ".actions input, .actions a", $(context).html ).button()

# Initialize all .actions buttons on page load
$ ->
  init_action_buttons()

# Enable any show/hide links (pass in the element you want to toggle with the data-element attribute
$ ->
  $('a.show-hide')
  .live 'click', ->
    element_id = $(this).data('element')
    $("#" + element_id).toggle('blind')
    false

# Remove the sidebar if it doesn't have content
$ -> 
  sidebar = $('#sidebar')
  if sidebar.children().length <= 0
    sidebar.hide()
    $('#layout').css('padding-left', 0)

