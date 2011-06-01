function new_patient_dialog() {
  $("#workflow-patient").dialog({ position: 'center', modal: true, title: 'Create New Patient', minHeight: 300, minWidth: 800 });
}

function close_patient_dialog() {
	$("#workflow-patient").dialog("close");
}

function new_patient_form(html) {
	$("#workflow-patient").html(html);
}

function set_patient_code(code) {
	$("#experiment_sample_attributes_test_subject_code").val(code);
}

function find_samples(url, code) {
  $.ajax(url + "?code=" + code);
}

function reset_sample_options(options) {
	$("#experiment_sample_id").html(options);
}

function add_new_selected_sample_option(id, name) {
	$("#experiment_sample_id").append('<option value="' + id + ' selected="selected">' + name + '</option>');
}

function new_sample_dialog() {
  $("#workflow-sample").dialog({ position: 'center', modal: true, title: 'Create New Sample', minHeight: 300, minWidth: 800 });
}

function close_sample_dialog() {
	$("#workflow-sample").dialog("close");
}

function new_sample_form(html) {
	( html == null || html == '' ) ?
		$('#workflow-sample').html("You must choose a valid patient first") :
		$("#workflow-sample").html(html)
}

function set_sample_readonly(html, id) {
	$('#sample-information').html(html);
	$('#sample-information').append('<input type="hidden" id="experiment_sample_id" name="experiment[sample_id]" value="' + id + '" />');
}
