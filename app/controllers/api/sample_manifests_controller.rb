class SampleManifiestsController < ApplicationController
  before_filter :find_sample_manifest

  

  private
  def find_sample_manifest
    @sample_manifest = SampleManifiest.find(params[:id]) if params[:id]
  end
end