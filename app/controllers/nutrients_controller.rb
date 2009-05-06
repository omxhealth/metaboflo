class NutrientsController < ApplicationController
  # GET /nutrients
  # GET /nutrients.xml
  def index
    @nutrients = Nutrient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nutrients }
    end
  end

  # GET /nutrients/1
  # GET /nutrients/1.xml
  def show
    @nutrient = Nutrient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nutrient }
    end
  end

  # GET /nutrients/new
  # GET /nutrients/new.xml
  def new
    @nutrient = Nutrient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nutrient }
    end
  end

  # GET /nutrients/1/edit
  def edit
    @nutrient = Nutrient.find(params[:id])
  end

  # POST /nutrients
  # POST /nutrients.xml
  def create
    @nutrient = Nutrient.new(params[:nutrient])

    respond_to do |format|
      if @nutrient.save
        flash[:notice] = 'Nutrient was successfully created.'
        format.html { redirect_to(@nutrient) }
        format.xml  { render :xml => @nutrient, :status => :created, :location => @nutrient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nutrient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nutrients/1
  # PUT /nutrients/1.xml
  def update
    @nutrient = Nutrient.find(params[:id])

    respond_to do |format|
      if @nutrient.update_attributes(params[:nutrient])
        flash[:notice] = 'Nutrient was successfully updated.'
        format.html { redirect_to(@nutrient) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nutrient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nutrients/1
  # DELETE /nutrients/1.xml
  def destroy
    @nutrient = Nutrient.find(params[:id])
    @nutrient.destroy

    respond_to do |format|
      format.html { redirect_to(nutrients_url) }
      format.xml  { head :ok }
    end
  end
end
