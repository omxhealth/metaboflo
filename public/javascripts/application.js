// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function set_flash(flash_type, message) {
	$("#flash").html("<p class=\"" + flash_type + "\">" + message + "</p>");
}
