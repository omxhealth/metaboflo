require 'yaml'
require 'active_record/fixtures'

@@data_path = Rails.root.to_s + '/data'

namespace :import do
  desc 'Import data into the database'

  task :all => [:environment, :sites, :animals]

  desc 'Import sites into database'
  task :sites => [:environment] do 
    puts 'Importing sites...'
    s = Site.new
    s.name = 'Dairy Research and Technology Centre (DRTC) - University of Alberta'
    s.save!
    @@site = s
  end
  
  # desc 'Import animals into database'
  # task :animals => [:environment] do
  #   puts "Importing animals..."
  #   import_models(Animal) 
  # end
  
  desc 'Import animals into database'
  task :animals => [:environment] do
    puts "Importing animals..."
    import_models(Animal) do |entity, row|
  
      entity.site = @@site
      true
    end
  end

end

def import_models(klass, csv_name=nil, &block)
  csv_name ||= klass.to_s.tableize
  headers = Hash.new
  entities = Array.new
  
  FasterCSV.foreach("#{@@data_path}/#{csv_name}.csv", :headers => true, :return_headers => true) do |row|
    # Get the indices for the header rows
    if row.header_row?
      headers = get_headers(row)
      next
    end

    # Process the data
    entity = klass.new
    headers.each_pair do |key, value|
      field = value
      next if field.blank?

      value = row[key]
      entity.send("#{field}=", value)
    end

    if block_given?
      next unless yield(entity, row)
    end
    
    entities << entity
    entity.save!
  end

  entities  
end

def get_headers(header_row)
  headers = Hash.new
  col_count = 0
  header_row.each do |col|
    headers[col_count] = col.first
    col_count += 1
  end
  headers
end