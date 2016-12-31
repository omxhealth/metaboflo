$(function() {
	function add_child(evt){
		evt.stopPropagation();
	    association = $(evt.currentTarget).attr('data-association');
	    template = $('#' + association + '_fields_template').html();
	    regexp = new RegExp('new_' + association, 'g');
	    new_id = new Date().getTime();

	    $(evt.currentTarget).parent().before(template.replace(regexp, new_id));
		return false;
	}
	function remove_child(evt){
		evt.stopPropagation();
	    hidden_field = $(evt.currentTarget).prev('input[type=hidden]')[0];
	    if (hidden_field) {
	      hidden_field.value = '1';
		}

	    $(evt.currentTarget).parents('.fields').hide();
	    return false;
	}

  $('form a.add_child').on('click', add_child)
  $('form a.remove_child').on('click', remove_child)
});
