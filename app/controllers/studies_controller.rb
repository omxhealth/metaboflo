require 'analysis'

class StudiesController < ApplicationController
  ALLOWED_CSV_EXPORT_KINDS = [:metaboanalyst, :umetrics].freeze

  include Analysis

  def index
    @studies = Study.all
  end

  def new
    @study = Study.new
  end

  def show
    @study = Study.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.metaboanalyst {
        csv_string = generate_csv( study_data(@study), kind: :metaboanalyst )
        send_data( csv_string, filename: @study.name.downcase.gsub(/[^0-9a-z]/, "_") + ".csv" )
      }
      format.umetrics {
        csv_string = generate_csv( study_data(@study), kind: :umetrics )
        send_data( csv_string, filename: @study.name.downcase.gsub(/[^0-9a-z]/, "_") + ".csv" )
      }
    end
  end

  def edit
    @study = Study.find(params[:id])
  end

  def create
    @study = Study.new(study_params)

    if @study.save
      flash[:notice] = 'Study was successfully created.'
      redirect_to(@study)
    else
      render action: "new"
    end
  end

  def update
    @study = Study.find(params[:id])

    if @study.update(study_params)
      flash[:notice] = 'Study was successfully updated.'
      redirect_to(action: 'show', id: @study)
    else
      render action: "edit"
    end
  end

  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    flash[:notice] = 'Study was successfully deleted.'
    redirect_to(action: 'index')
  end

  def analysis
    @study = Study.find(params[:id])

    data = study_data(@study)
    csv_string = generate_csv(data, kind: :metaboanalyst)

    labelh = Hash.new
    data.each do |d|
      labelh[d[:label]] = ''
    end
    @labels = labelh.keys().sort()

    @pca_image = pca(csv_string)
    @corr_image = corr(csv_string)
  end

  private

  def study_data(study)
    data = Array.new

    # For each cohort (label)
    study.cohorts.each do |cohort|
      # For each instance in this cohort (label)
      cohort.test_subjects.each do |test_subject|
        # Create the data array for processing
        data << {label: cohort.label, features: test_subject.features, id: test_subject.code}
      end
    end
    data
  end

  # Passed an array of instances, represented by hashes. Takes an options hash which includes
  # a :kind which indicates :umetrics or :metaboanalyst
  def generate_csv(data, options={})
    raise ArgumentError unless ALLOWED_CSV_EXPORT_KINDS.include?(options[:kind])

    CSV.generate do |csv|
      #Do first pass of the data to get a list of feature names:
      feature_names = []
      data.each do |d|
        d[:features].keys.each do |fname|
          if !feature_names.include?(fname)
            feature_names << fname
          end
        end
      end

      if options[:kind] == :metaboanalyst
        csv << ["subjectID", "Label"] + feature_names
      elsif options[:kind] == :umetrics
        csv << ["subjectID"] + feature_names + [ "Label" ]
      end

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

        if options[:kind] == :metaboanalyst
          csv << [d[:id], d[:label]] + features
        elsif options[:kind] == :umetrics
          csv << [d[:id]] + features + [d[:label]]
        end
      end
    end
  end

  def study_params
    params.require(:study).permit!
  end
end
