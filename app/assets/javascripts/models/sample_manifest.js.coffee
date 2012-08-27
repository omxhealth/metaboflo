class Metaboflo.Models.SampleManifest extends Backbone.Model
	defaults:
		biofluid_sample_manifests: []
		cell_sample_manifests: []
		tissue_sample_manifests: []
	
	urlRoot: "/api/sample_manifest"