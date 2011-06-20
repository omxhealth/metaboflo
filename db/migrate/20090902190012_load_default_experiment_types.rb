require 'active_record/fixtures'

class LoadDefaultExperimentTypes < ActiveRecord::Migration
  def self.up
    # Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "defaults" ), :experiment_types)
  end

  def self.down
    # ExperimentType.delete_all
  end
end