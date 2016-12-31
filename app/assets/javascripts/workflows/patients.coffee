# Enable the autocomplete for any test subject autocomplete fields
$ ->
  $('.test-subject-autocomplete').each ->
    input_field = $(this)
    input_field.autocomplete
      minLength: 2
      select: (event, ui) -> # Update the value of the form ID field (hidden) for the foreign key on select
        $('#' + input_field.data('update')).val(ui.item.id).change()
      source: (request, response) -> 
        $.ajax
          url: input_field.data('source')
          dataType: 'json'
          data: 
            term: request.term
          success: (data, textStatus, jqXHR) ->
            response( $.map( data, (item) -> # Return a JSON structure with the label to display and the metabolite ID
              { label: item.to_label, id: item.id } ) )

