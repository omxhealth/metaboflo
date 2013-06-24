# Load dynamic select boxes (with extra 'other' to add a new field)
@load_dynamic_others = (context) ->
  if !context
    context = document
  else
    context = context
  c = $(context)
  $('.dynamic-other', c).each -> 
    $(this).on 'change', ->
      newElementOnOther(this)

# Set an error and error message on the given field. This wraps the field form elements in error divs
# and sets an error message if there is a data-validate element for the given field
@set_field_error = (field) ->
  field.find('label, input, textarea, select').wrap('<div class="field_with_errors" />')
  field.append('<p class="error-msg">' + field.data('validate') + '</p>') if field.data('validate')

# Clear the given form of all errors and error messages
@clear_field_errors = (form) ->
  form.find('.field_with_errors').find('label, input, textarea, select').unwrap()
  form.find('p.error-msg').remove()

# Set the errors on all fields that contain errors (from the returned JSON). If the error is general,
# display a default message
@set_field_errors = (form, xhr) ->
  clear_field_errors( form )
  try # Populate errorText with the client errors if there are any
    set_field_error($('#' + k + "-knoxy-field")) for k, v of JSON.parse xhr.responseText
  catch err  # The responseText isn't valid JSON (like if a 500 exception), set errors with a generic error message.
    form.find('div.validation-error').
            html("There were errors with the submission: Please reload the page and try again")

# Set the flash message to the given message for the given type
@set_flash = (flash_type, message) ->
  $("#flash-messages").html("<p class=\"flash flash-" + flash_type + "\">" + message + "</p>")

# Load all date pickers for the current context, or if not provided, the entire document. This can be called
# with the responseText from successful AJAX calls.
@datepickers = (context) ->
  context = document if !context
  c = $(context)
  $( '.datepicker', c ).each -> 
    $(this).datepicker
      changeYear: true
      buttonImage: "/assets/icons/calendar.gif"
      buttonImageOnly: true
      showOn: "button"

# Align the left labels and elements of the given form based on the largest label in the form.
@align_form = (form) ->
  parent_width = form.width()
  max = 0
  labels = form.find('.left-label, .field_with_errors > label')
  labels.each -> 
    max = $(this).width() if $(this).width() > max
  labels.width(max)
  
  # Set the inner group widths (inline-block elements require a width)
  inner_groups = form.find('.inner-group-field > .inner-group')
  inner_groups.css('min-width', (parent_width - max - 200) )
      
  # form.find('#submit, p.error-msg, .field-no-label').css("margin-left", max + 10)

# Align the left labels and elements of the given form based on the largest label in the form.
@disable_double_submit = ->
  input = $("<input type='hidden' id='double-submit-commit'/>").attr("name", $(this)[0].name).attr("value", $(this)[0].value)
  $(this).closest('form').append(input)
  $(this).attr('disabled', 'disabled').val('Loading...')
  $(this).closest('form').submit()

@reenable_submit_on_error = (button) ->
  input = button.closest('form').find('#double-submit-commit')
  original_value = input.val()
  # input.remove()
  $(button).val(original_value).removeAttr('disabled')

# Support adding/removing nested attributes from form
$ -> 
  ###
  $('form a.add_child').on 'click', ->
    association = $(this).attr('data-association')
    template = $('#' + association + '_fields_template').html()
    regexp = new RegExp('new_' + association, 'g')
    new_id = new Date().getTime()

    to_add = $( template.replace(regexp, new_id) ).hide()
    $(this).parent().before(to_add)
    to_add.slideDown()
    $(this).trigger('nest-added', to_add)

    return false
  ###
  $('form .nested-remove a').live 'click', ->
    hidden_field = $(this).prev('input[type=hidden]')[0]
    if hidden_field
      field_holder = $(this).parents('.nested-field')
      if hidden_field.value == '1' # Already set to delete, so undo
        hidden_field.value = '0'
        field_holder.find('input, textarea, select').attr('disabled', false)
        $(this).children('.ui-button-text').text('remove')
        field_holder.removeClass('nested-removed', 800)
      else
        hidden_field.value = '1'
        field_holder.find('input, textarea, select').attr('disabled', true)
        $(this).children('.ui-button-text').text('undo')
        field_holder.addClass('nested-removed', 1000)

    $(this).prev('input[type=hidden]').attr('disabled', false)  
    return false

# Load any date picker fields
$ ->
  $('form').each ->
    datepickers( $(this) )

# Align the labels of all forms in the document on page load, and disable double submits
$ ->
  $('form').each ->
    align_form( $(this) )

$ ->
  $('form').each ->
    load_dynamic_others( $(this) )

# If errors are present on the page, move to the form
$ ->
  if $('.error-explanation').length > 0
    $('html, body').animate( { scrollTop: $(".error-explanation").offset().top }, 1000 )

