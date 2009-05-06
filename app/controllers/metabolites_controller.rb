class MetabolitesController < ApplicationController
  # GET /metabolites
  # GET /metabolites.xml
  def index
    params[:page] = 1 if params[:page].to_i <= 0
    @metabolites = Metabolite.paginate(:page => params[:page], :order => 'hmdb_id')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @metabolites }
    end
  end

  # GET /metabolites/1
  # GET /metabolites/1.xml
  def show
    @metabolite = Metabolite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @metabolite }
    end
  end

  # GET /metabolites/new
  # GET /metabolites/new.xml
  def new
    @metabolite = Metabolite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @metabolite }
    end
  end

  # GET /metabolites/1/edit
  def edit
    @metabolite = Metabolite.find(params[:id])
  end

  # POST /metabolites
  # POST /metabolites.xml
  def create
    @metabolite = Metabolite.new(params[:metabolite])

    respond_to do |format|
      if @metabolite.save
        flash[:notice] = 'Metabolite was successfully created.'
        format.html { redirect_to(@metabolite) }
        format.xml  { render :xml => @metabolite, :status => :created, :location => @metabolite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @metabolite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /metabolites/1
  # PUT /metabolites/1.xml
  def update
    @metabolite = Metabolite.find(params[:id])

    respond_to do |format|
      if @metabolite.update_attributes(params[:metabolite])
        flash[:notice] = 'Metabolite was successfully updated.'
        format.html { redirect_to(@metabolite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @metabolite.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /metabolites/1
  # DELETE /metabolites/1.xml
  def destroy
    @metabolite = Metabolite.find(params[:id])
    @metabolite.destroy

    respond_to do |format|
      format.html { redirect_to(metabolites_url) }
      format.xml  { head :ok }
    end
  end
end
