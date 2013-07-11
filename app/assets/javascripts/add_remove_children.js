$(function() {
	function add_child(event){
		event.stopPropagation();
	    var association = $(event.currentTarget).attr('data-association');
	    var template = $('#' + association + '_fields_template').html();
	    var regexp = new RegExp('new_' + association, 'g');
	    var new_id = new Date().getTime();

	    $(event.currentTarget).parent().before(template.replace(regexp, new_id));
		return false;
	}
	
	function remove_child(event){
		event.stopPropagation();
	    var hidden_field = $(event.currentTarget).prev('input[type=hidden]')[0];
	    if (hidden_field) {
	      hidden_field.value = '1';
		}

	    $(event.currentTarget).parents('.fields').hide();
	    return false;
	}

    $('form a.add_child').on('click', add_child);
    $('form a.remove_child').live('click', remove_child);
	
});
