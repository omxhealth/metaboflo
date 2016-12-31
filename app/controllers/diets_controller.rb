class DietsController < ApplicationController
  # GET /diets
  # GET /diets.xml
  def index
    @diets = Diet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diets }
    end
  end

  # GET /diets/1
  # GET /diets/1.xml
  def show
    @diet = Diet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diet }
    end
  end

  # GET /diets/new
  # GET /diets/new.xml
  def new
    @diet = Diet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diet }
    end
  end

  # GET /diets/1/edit
  def edit
    @diet = Diet.find(params[:id])
  end

  # POST /diets
  # POST /diets.xml
  def create
    @diet = Diet.new(params[:diet])

    respond_to do |format|
      if @diet.save
        flash[:notice] = 'Diet was successfully created.'
        format.html { redirect_to(@diet) }
        format.xml  { render :xml => @diet, :status => :created, :location => @diet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diets/1
  # PUT /diets/1.xml
  def update
    @diet = Diet.find(params[:id])

    respond_to do |format|
      if @diet.update_attributes(params[:diet])
        flash[:notice] = 'Diet was successfully updated.'
        format.html { redirect_to(@diet) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diets/1
  # DELETE /diets/1.xml
  def destroy
    @diet = Diet.find(params[:id])
    @diet.destroy

    respond_to do |format|
      format.html { redirect_to(diets_url) }
      format.xml  { head :ok }
    end
  end
end
