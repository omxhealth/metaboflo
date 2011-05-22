class DataFile < ActiveRecord::Base
  belongs_to :experiment
  has_attached_file :data, :url => "/system/:attachment/:id/:filename", :path => ":rails_root/public/system/:attachment/:id/:filename"
  
  belongs_to :data_file_type
  belongs_to :experiment
  
  has_many :concentrations
  
  serialize :mapping_errors, Array
  
  after_save :save_concentrations
  
  def root
    experiment.root
  end
  
  def save_concentrations
    if has_concentrations and self.mapping_errors == nil
      self.mapping_errors = Array.new
      FasterCSV.foreach(self.data.path, :headers => false) do |row|
        add_concentration(row[0], row[1]) #Each row is a concentration
      end
      self.save!
    end
  end
  
  private
  def add_concentration(name, value)
    if name.length > 0
      met = Metabolite.find(:first, :conditions => "name = '#{name}' OR name = '#{name.gsub(/-/,'')}'")

      if met == nil
        #If we couldn't find it by name, attempt to find it by synonyms
        potential_matches = Metabolite.find(:all, :conditions => "synonyms like '%#{name}%'")
        found_met = nil
        potential_matches.each do |match|
          match.synonyms.split(';').each do |syn|
            syncleaned = syn.strip.downcase
            namecleaned = name.strip.downcase
            if syncleaned.gsub(/-/,'') == namecleaned or syncleaned == namecleaned
              found_met = match
            end
          end
        end
        
        if not found_met.nil?
          met = found_met
        end
      end
    
      if met != nil
        c = Concentration.new()
        c.concentration_value = value
        c.concentration_units = self.has_concentration_units
        c.metabolite = met
        c.identified_as = name
        c.data_file = self
        c.save!
      else
        self.mapping_errors << name
      end
    end
  end
  
end
