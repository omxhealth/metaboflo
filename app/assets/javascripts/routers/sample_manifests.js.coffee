class Metaboflo.Routers.SampleManifests extends Backbone.Router
	routes:
		# 'clients/sample_manifests/': "index"
		'clients/sample_manifests': "index"
		'clients/sample_manifests/new': 'new'
		'clients/sample_manifests/:id/edit': 'edit'
		'clients/sample_manifests/:id': 'show'	

	show: (id) -> alert("show record #{id}")
	
	new: ->
		model = new Metaboflo.Models.SampleManifest(client_id: $('#sample_manifest_form').data("client"))
		model.save(wait: true)
		view = new Metaboflo.Views.SampleManifestNew(model: model)
		$('#sample_manifest_form').html(view.render().el)
	edit: (id) -> alert "edit record #{id}"
	
	index: -> alert "index"
	
	