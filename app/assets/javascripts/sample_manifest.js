$(function() {
	
	$(".tab").tabs({selected: 0});
	$("#test_descriptions").accordion();
	$("#sample-manifest-form").tabs({selected: 0});
	$("#module_1_dialog").dialog({
		title: "Module 1 - Biocrates p180 kit",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#module_2_dialog" ).dialog({
		title: "Module 2 - Glycolysis, Krebs (TCA) Cycle and Bioenergetics - LC/MS",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#module_3_dialog" ).dialog({
		title: "Module 3 - Amino Acids, Urea cycle and Metabolites - LC/MS",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#module_4_dialog" ).dialog({
		title: "Module 4 - Acyl Carnitines - LC/MS",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#module_5_dialog" ).dialog({
		title: "Module 5 - Glycolysis, Krebs and the Pentose Cycle - GC/MS",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#gc_fap_dialog" ).dialog({
		title: "GC-FAP - GC-FID Fatty acid profiling",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#ss_1_dialog" ).dialog({
		title: "SS 1 - Lipogenesis by Deuterated H<sub>2</sub>O",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	$( "#ss_2_dialog" ).dialog({
		title: "SS 2 - Stable Isotope intraperitoneal glucose tolerance test",
		height: 600,
		width: 1050,
		modal: true,
		autoOpen: false
	});
	
	$(".button").button()
	$("#module_1").button().click(function(){$( "#module_1_dialog" ).dialog("open");});
	$("#module_2").button().click(function(){$( "#module_2_dialog" ).dialog("open");});
	$("#module_3").button().click(function(){$( "#module_3_dialog" ).dialog("open");});
	$("#module_4").button().click(function(){$( "#module_4_dialog" ).dialog("open");});
	$("#module_5").button().click(function(){$( "#module_5_dialog" ).dialog("open");});
	$("#gc_fap").button().click(function(){$( "#gc_fap_dialog" ).dialog("open");});
	$("#ss_1").button().click(function(){$( "#ss_1_dialog" ).dialog("open");});
	$("#ss_2").button().click(function(){$( "#ss_2_dialog" ).dialog("open");});
	$(".link_to").button().click(function(evt){window.open($(evt.currentTarget).data("url"));});
	$(".close").button()
	$("#print_manifest").click(function(evt){window.open($(evt.currentTarget).data("url"));})
	$( "#tabs" ).tabs();
});

