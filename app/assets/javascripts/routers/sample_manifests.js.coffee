class Metaboflo.Routers.SampleManifests extends Backbone.Router
	routes:
		# 'clients/sample_manifests/': "index"
		'clients/sample_manifests': "index"
		'clients/sample_manifests/new': 'new'
		'clients/sample_manifests/:id/edit': 'edit'
		'clients/sample_manifests/:id': 'show'	

	show: (id) -> alert("show record #{id}")
	
	new: ->
		view = new Metaboflo.Views.SampleManifestNew(model: new Metaboflo.Models.SampleManifest)
		$('#sample_manifest_form').html(view.render().el)
	edit: (id) -> alert "edit record #{id}"
	
	index: -> alert "index"
	
	