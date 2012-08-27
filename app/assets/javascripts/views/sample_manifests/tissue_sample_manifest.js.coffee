class Metaboflo.Views.TissueSampleManifest extends Backbone.View
	template: JST['sample_manifest/tissue_sample_manifest']
	
	render: ->
		$(@el).html(@template(tissue_sample_manifest: @model))
		this