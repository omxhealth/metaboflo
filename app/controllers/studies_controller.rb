class StudiesController < ApplicationController
  before_filter :load_cohorts

  require 'faster_csv'

  def export
    @study = Study.find(params[:id])

    data = Array.new
    
    #For each cohort (label)
    @study.cohort_assignments.each do |ca|
      curr_label = ca.label
      c = ca.assignable
      
      #For each instance in this cohort (label)
      c.cohort_assignments.each do |ca|
        instance = ca.assignable
        #Create the data array for processing
        data << {:label => curr_label, :features => instance.features, :id => instance.code}
      end
    end
    
    csv_string = generate_csv(data)

    filename = @study.name.downcase.gsub(/[^0-9a-z]/, "_") + ".csv"
    send_data(csv_string, :type => 'text/csv; charset=utf-8; header=present', :filename => filename)
    #iso-8859-1
  end


  def index
    @studies = Study.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studies }
    end
  end
  
  def new
    @study = Study.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study }
    end
  end
  
  def show
    @study = Study.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study }
    end
  end

  def edit
    @study = Study.find(params[:id])
  end

  def create
    @study = Study.new(params[:study])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'Study was successfully created.'
        format.html { redirect_to(@study) }
        format.xml  { render :xml => @study, :status => :created, :location => @study }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @study = Study.find(params[:id])

    respond_to do |format|
      if @study.update_attributes(params[:study])
        flash[:notice] = 'Study was successfully updated.'
        format.html { redirect_to(:action => 'show', :id => @study) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    respond_to do |format|
      flash[:notice] = 'Study was successfully deleted.'
      format.html { redirect_to(:action => 'index') }
      format.xml  { head :ok }
    end
  end  
  
  private 
  
  def load_cohorts
    Cohort #Required to load all Cohort types
  end
  
  # Passed an array of instances, represented by hashes
  def generate_csv(data)
    csv_string = FasterCSV.generate do |csv|
      #Do first pass of the data to get a list of feature names:
      feature_names = []
      data.each do |d|
        d[:features].keys.each do |fname|
          if not feature_names.include?(fname)
            feature_names << fname
          end
        end
      end
      
      csv << ["Sample", "Label"] + feature_names
            
      #Now create the rows (using the feature_names array to order each feature vector)
      data.each do |d|
        features = Array.new
        curr_d = d[:features]
        feature_names.each do |f|
          if curr_d.has_key?(f)
            features << curr_d[f]
          else
            features << '' #This sample doesnt have this feature
          end
        end
        
        csv << [d[:id], d[:label]] + features
      end
    end
    
    return(csv_string)
  end
  
end
