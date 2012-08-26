window.Metaboflo =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: -> 
		new Metaboflo.Routers.SampleManifests
		Backbone.history.start(pushState: true)

$(document).ready ->
  Metaboflo.init()
