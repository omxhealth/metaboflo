class Metaboflo.Views.BiofluidSampleManifest extends Backbone.View
	template: JST['sample_manifests/biofluid_sample_manifest']
	events:
		'change .data_field': 'update_data_field'
	
	update_data_field: (event)->
		@model.set($(event.target).data("field"),$(event.target).attr('value'))

	render: ->
		$(@el).html(@template(biofluid_sample_manifest: @model))
		this