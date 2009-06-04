require 'yaml'
require 'active_record/fixtures'

@@data_path = Rails.root.to_s + '/data'

namespace :import do
  desc 'Import data into the database'

  task :all => [:environment, :users, :sites, :test_subjects, :diets, :meals]

  desc 'Destroy all existing users and load initial users.'
  task :users => [:environment] do |t|
    puts 'Importing users...'
    User.transaction do
      User.destroy_all

      admin = User.new(:login => 'admin', :email => 'info@insiliflo.com', :password => 'ruminal', :password_confirmation => 'ruminal', :rank => 'Administrator')
      admin.save!
    end
  end

  desc 'Import sites into database'
  task :sites => [:environment] do 
    puts 'Importing sites...'
    Site.transaction do
      Site.destroy_all
      
      s = Site.new
      s.name = 'Dairy Research and Technology Centre (DRTC) - University of Alberta'
      s.save!
      @@site = s
      
      s = Site.new
      s.name = 'University of Alberta'
      s.save!
    end
  end
  
  desc 'Import test_subjects into database'
  task :test_subjects => [:environment] do
    puts "Importing test_subjects..."
    TestSubject.transaction do
      TestSubject.destroy_all
      import_models(TestSubject) do |entity, row|
        entity.site = @@site
        true
      end
    end
  end
  
  desc 'Import diets, ingredients, and nutrients into database'
  task :diets => [:environment] do
    puts "Importing diets / ingredients / nutrients..."
    Diet.transaction do
      Diet.destroy_all
      Ingredient.destroy_all
      Nutrient.destroy_all
      
      headers = Hash.new
      @@diets = Hash.new
      nutrients = false

      FasterCSV.foreach("#{@@data_path}/diets.csv", :headers => true, :return_headers => true) do |row|
        # Get the indices for the header rows
        if row.header_row?
          headers = get_headers(row)
        
          headers.values.each do |v|
            if v != 'Ingredients'
              @@diets[v] = Diet.new(:name => v) #Create each diet
            end
          end
        
          next
        end

        if row[0] == 'Nutrient composition' #We've entered the Nutrient subsection
          nutrients = true
          next
        end
      
        vals = Hash.new
        name = ''
        row.each do |k, v|
          if k == 'Ingredients'
            name = v.strip()
          else
            vals[k] = v.strip()
          end
        end
      
        if not nutrients
          i = Ingredient.new(:name => name)
          i.save!
          
          #Save each ingredient / diet pair for this ingredient
          vals.each_pair do |k, v|
            diet = @@diets[k]
            di = DietIngredient.new(:amount => v, :diet => diet, :ingredient => i)
            di.save!
          end
        
        else
          n = Nutrient.new(:name => name)
          n.save!
        
          #Save each nutrient / diet pair for this ingredient
          vals.each_pair do |k, v|
            diet = @@diets[k]
            c = Composition.new(:amount => v, :diet => diet, :nutrient => n)
            c.save!
          end
        end
      end
    end
  end
  
  desc 'Import meals into database'
  task :meals => [:environment] do
    puts "Importing meals..."
    Meal.transaction do
      Meal.destroy_all
      
      headers = Hash.new

      FasterCSV.foreach("#{@@data_path}/feed.csv", :headers => true, :return_headers => true) do |row|
        if row.header_row?
          next
        end

        vals = Hash.new
        cow_id = diet = period = ''
        row.each do |k, v|
          if k == 'Cow'
            cow_id = v.strip()
          elsif k == 'Diet'
            diet = @@diets[v.strip()]
          elsif k == 'Period'
            period = v.strip()
          else
            vals[k.strip()] = v.strip()
          end
        end
        
        vals.each_pair do |k, v|
          matches = k.match(/^Day (\d+)$/)
          day = matches[1]
          a = TestSubject.find(:first, :conditions => "code = '#{cow_id}'")
          f = Meal.new(:amount => v, :test_subject => a, 
                       :diet => diet, :consumed_during_period => period,
                       :consumed_on_day => day)
          
          f.save!
        end
        
      end
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