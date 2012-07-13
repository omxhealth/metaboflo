require 'active_record/fixtures'

@@all_models = [:sites, :users, :protocols, :test_subjects, :groupings, :grouping_assignments, :lab_tests, :test_subject_evaluations, :samples, :experiment_types, :experiments, :data_file_types, :data_files, :task_statuses, :task_categories, :task_priorities, :tasks]

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
   ActiveRecord::Fixtures.create_fixtures(File.join(File.dirname(__FILE__), 'demo'), models.to_sym)
end

def load_data_files
  counter = 0
  TestSubject.all.each do |ts|
    counter += 1
    user = User.find(:first)
    exptype = ExperimentType.first
    s = ts.samples.first || ts.samples.create!(:sample_type => 'urine', :collected_on => Date.today, :barcode => "673#{counter}",
                                               :original_amount => 100.0, :original_unit => 'mL', :building => 'Bio Sci', :room => '235',
                                               :collected_by_id => user.id)
    e = s.experiments.first || s.experiments.create!(:name => "Experiment for #{ts.id}", :experiment_type => exptype,
                                                     :description => "#{exptype.name} Experiment -- Batch upload of Cachexia data.",
                                                     :assigned_to => user, :perform_on => Date.today, :performed_on => Date.today, 
                                                     :performed_by => user)
    
    csv = "#{ts.id}.csv"
    path = File.join(File.dirname(__FILE__), "demo", "data_files", csv)
    
    f = File.new(path, "r")
          
    data_file = e.data_files.create!(:data => f, :data_file_type => DataFileType.find_by_name('CSV'), :has_concentrations => true, :has_concentration_units => 'uM')
  end
end

def dump_models(models)
  instances = {}
  models.to_s.singularize.camelize.constantize.find(:all).each do |instance|
    instances.store(instance.to_param, instance.attributes)
  end
  File.open(File.join(File.dirname(__FILE__), "demo/#{models}.yml"), 'w') { |file| file.write(instances.to_yaml) }
end
