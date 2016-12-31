class SitesController < ApplicationController
  before_action :only_user?, only: [ :new, :create, :edit, :update ]
  before_action :administrator?, only: [ :destroy ]

  # GET /sites
  # GET /sites.xml
  def index
    @sites = Site.order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.xml
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.xml
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  # POST /sites.xml
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        flash[:notice] = 'Site was successfully created.'
        format.html { redirect_to(@site) }
        format.xml  { render xml: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.xml
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update(site_params)
        flash[:notice] = 'Site was successfully updated.'
        format.html { redirect_to(@site) }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.xml
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to(sites_url) }
      format.xml  { head :ok }
    end
  end

  private

  def only_user?(redirect_path = sites_path)
    super
  end

  def administrator?(redirect_path = sites_path)
    super
  end

  def site_params
    params.require(:site).permit!
  end
end
