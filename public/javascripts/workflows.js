function find_samples(url, code) {
  $.ajax(url + "?code=" + code);
}

function new_patient() {
  $('#workflow-patient').dialog({ position: 'center', modal: true, title: 'Create New Patient', minHeight: 300, minWidth: 800 });
}

function new_sample() {
  $('#workflow-sample').dialog({ position: 'center', modal: true, title: 'Create New Sample', minHeight: 300, minWidth: 800 });
}
