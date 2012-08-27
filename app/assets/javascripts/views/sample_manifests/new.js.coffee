class Metaboflo.Views.SampleManifestNew extends Backbone.View
	template: JST['sample_manifests/new']
	
	events:
	# 	'submit #new_sample_manifest': 'createSampleManifest'
		'click #add_biofluid_sample_manifest': 'add_biofluid_sample_manifest'
		# 'click #add_cell_sample_manifest': 'add_cell_sample_manifest'
		# 'click #add_tissue_sample_manifest': 'add_tissue_sample_manifest'

	add_biofluid_sample_manifest: ->
		model = new Metaboflo.Models.BiofluidSampleManifest
		view = new Metaboflo.Views.BiofluidSampleManifest(model: new Metaboflo.Models.BiofluidSampleManifest)
		console.log(view.model)
		@$('#biofluid_sample_manifests').append(view.render().el)

	initialize: ->
		
	render: ->
		$(@el).html(@template(sample_manifest: @model))
		this