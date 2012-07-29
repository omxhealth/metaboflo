$(function(){
	$(".button").button();
	$("#print_manifest").click(function(evt){window.open($(evt.currentTarget).data("url"));})
	
})