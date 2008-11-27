require 'active_record/fixtures'

class LoadDefaultDataFileTypes < ActiveRecord::Migration

    def self.up
      Fixtures.create_fixtures(File.join(File.dirname(__FILE__), "defaults" ), :data_file_types)
    end

    def self.down
      DataFileType.delete_all
    end

end