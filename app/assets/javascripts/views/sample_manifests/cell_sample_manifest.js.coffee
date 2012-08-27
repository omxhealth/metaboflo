class Metaboflo.Views.CellSampleManifest extends Backbone.View
	template: JST['sample_manifest/cell_sample_manifest']
	
	render: ->
		$(@el).html(@template(cell_sample_manifest: @model))
		this