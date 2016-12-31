// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function set_flash(flash_type, message) {
	$("#flash").html("<p class=\"" + flash_type + "\">" + message + "</p>");
}

function newBatchSamples() {
  var n = prompt("Enter number of samples to create", "");
  n = parseInt(n);
  if (isNaN(n)) {
    alert('Error: Invalid Input!');
  } else if (n > 100) {
    alert('Error: Number of samples must be less than 100!');
  } else {
    window.location = '/batches/batches/new?num_samples='+n;
  }
  event.preventDefault();
}