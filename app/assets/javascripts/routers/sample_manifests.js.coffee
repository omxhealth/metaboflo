class Metaboflo.Routers.SampleManifests extends Backbone.Router
	routes:
		# 'clients/sample_manifests/': "index"
		'clients/sample_manifests': "index"
		'clients/sample_manifests/new': 'new'
		'clients/sample_manifests/:id/edit': 'edit'
		'clients/sample_manifests/:id': 'show'	
	show: (id) -> alert("show record #{id}")
	new: -> alert "new record"
	edit: (id) -> alert "edit record #{id}"
	index: -> alert "index"
	
	