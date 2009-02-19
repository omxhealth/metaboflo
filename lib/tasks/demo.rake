require 'active_record/fixtures'

@@all_models = [:sites, :users, :protocols, :animals, :cohorts, :cohort_assignments, :lab_tests, :animal_evaluations, :samples, :experiments, :data_files, :task_statuses, :task_categories, :task_priorities, :tasks]

namespace :demo do
  desc 'Import demo data into database.'
  task :load => [:environment] do |t|
    @@all_models.each do |models|
      load_fixture models
    end
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

def dump_models(models)
  instances = {}
  models.to_s.singularize.camelize.constantize.find(:all).each do |instance|
    instances.store(instance.to_param, instance.attributes)
  end
  File.open(File.join(File.dirname(__FILE__), "demo/#{models}.yml"), 'w') { |file| file.write(instances.to_yaml) }
end
