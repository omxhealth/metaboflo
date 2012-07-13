

# Show/hide the concentration import checkbox based on whether the user has selected the CSV file type
# for a data file.
$ -> 
  $('.file-type-select').live 'change', -> 
    has_concentrations = $(this).parents('.field-holder').next('.has-concentrations')
    if( $(this).find("option:selected").text() == 'CSV' )
      has_concentrations.fadeIn()
    else 
      has_concentrations.fadeOut()

# Open the "Add New Patient" window in a jQuery dialog box
$ ->
  $('#open-patient-dialog').click ->
    url = this.href
    $('<div id="workflow-patient-dialog">').dialog
      modal: true
      open: -> 
        $(this).load url, ->
          align_form( $('form#new_test_subject') )
          init_action_buttons()
          $('form#new_test_subject').find('input:submit').each -> # Disabled the submit button so no one can submit twice
            $(this).click(disable_double_submit)
      draggable: false
      resizable: false
      dialogClass: 'add-workflow-patient' # Give the dialog the CSS class
      title: 'Create New Patient'
      position: 'top'
      close: ->
        $(this).remove() # Remove the HTML for the dialog
    
    false # prevent the browser to follow the link

# Bind events that occur when the new patient form is submitted. We catch errors and let the user know, or 
# if the form is correct, submit it (creating the patient) and close the dialog.
$ ->
  $("form#new_test_subject")
    .live "ajax:success", (event, data, status, xhr) ->
      patient = jQuery.parseJSON(xhr.responseText)

      $("#workflow-patient-dialog").dialog("close") # Close the dialog window
      $('#sample-id').append("<option value=\"#{patient.last_sample_id}\"></option>") # Add the new sample ID to the select
      $('#patient-selector').hide() # Hide the patient selection section
      $('#sample-added-show').load "/workflows/samples/#{patient.last_sample_id}", -> # Load the HTML partial for the results
        $(this).effect("highlight", {}, 3000);
      set_flash('notice', 'Patient added successfully')
      
    .live "ajax:error", (evt, xhr, status, error) ->
      $(this).find('input:submit').each -> # Re-enable the submit button when there is an error submitting the form
        reenable_submit_on_error($(this))
      set_field_errors( $(this), xhr )
      align_form( $(this) )


# Fade in the sample fields when the user find the patient they are looking for
$ ->
  $('#test-subject-id').on 'change', (event) ->
    $("#sample-selector").fadeIn()


# Open the "Add New Sample" window in a jQuery dialog box
$ ->
  $('#open-sample-dialog').click ->
    url = this.href
    patient_id = $('#test-subject-id').val()
    $('<div id="workflow-sample-dialog">').dialog
      modal: true
      open: -> 
        $(this).load url + '?' + $.param({ 'patient_id': patient_id }), ->
          align_form( $('form#new_sample') )
          init_action_buttons()
          $('form#new_sample').find('input:submit').each -> # Disabled the submit button so no one can submit twice
            $(this).click(disable_double_submit)
      draggable: false
      resizable: false
      dialogClass: 'add-workflow-sample' # Give the dialog the CSS class
      title: 'Create New Sample'
      position: 'top'
      close: ->
        $(this).remove() # Remove the HTML for the dialog
    
    false # prevent the browser to follow the link

# Bind events that occur when the new sample form is submitted. We catch errors and let the user know, or 
# if the form is correct, submit it (creating the sample) and close the dialog.
$ ->
  $("form#new_sample")
    .live "ajax:success", (event, data, status, xhr) ->
      $("#workflow-sample-dialog").dialog("close") # Close the dialog window
      sample = jQuery.parseJSON(xhr.responseText)
      $('#sample-id').append("<option value=\"#{sample.id}\">#{sample.to_label}</option>")
      set_flash('notice', 'Sample added successfully')

    .live "ajax:error", (evt, xhr, status, error) ->
      $(this).find('input:submit').each -> # Re-enable the submit button when there is an error submitting the form
        reenable_submit_on_error($(this))
      set_field_errors( $(this), xhr )
      align_form( $(this) )
