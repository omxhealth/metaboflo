require 'active_record/fixtures'

@@all_models = [:sites, :users, :protocols, :test_subjects, :cohorts, :cohort_assignments, :lab_tests, :test_subject_evaluations, :samples, :experiment_types, :experiments, :data_files, :task_statuses, :task_categories, :task_priorities, :tasks]

namespace :demo do
  desc 'Import demo data into database.'
  task :load => [:environment] do |t|
    @@all_models.each do |models|
      load_fixture models
    end
    load_data_files
  end

  desc 'Create demo data from data in database.'
  task :dump => [:environment] do |t|
    @@all_models.each do |models|
      dump_models models
    end
  end
end

def load_fixture(models)
  Fixtures.create_fixtures(File.join(File.dirname(__FILE__), 'demo'), models.to_sym)
end

def load_data_files
  TestSubject.all.each do |ts|
    s = ts.samples.first || ts.samples.create!
    e = s.experiments.first || s.experiment.create!(:name => "Experiment for #{ts.id}", :experiment_type => ExperimentType.first)
    
    csv = "#{ts.id}.csv"
    path = File.join(File.dirname(__FILE__), "demo", "data_files", csv)
    f = File.new(path, "r")
    (class << f; self; end).class_eval do
      alias local_path path
      define_method(:original_filename) {csv}
      define_method(:content_type) {"text/plain"}
      define_method(:size) { File.size(path) }
    end
          
    data_file = e.data_files.create!(:uploaded_data => f, :data_file_type => DataFileType.find_by_name('CSV')
  end
end

def dump_models(models)
  instances = {}
  models.to_s.singularize.camelize.constantize.find(:all).each do |instance|
    instances.store(instance.to_param, instance.attributes)
  end
  File.open(File.join(File.dirname(__FILE__), "demo/#{models}.yml"), 'w') { |file| file.write(instances.to_yaml) }
end
