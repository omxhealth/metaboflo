class DataFile < ActiveRecord::Base
  has_attachment :storage => :file_system, :path_prefix => 'public/files', :max_size => 200.megabytes
  validates_as_attachment
  validates_presence_of :data_file_type_id
  
  belongs_to :data_file_type
  belongs_to :experiment
  
  has_many :concentrations
  
  def root
    experiment.root
  end
  
  def after_save
    if has_concentrations    
      FasterCSV.foreach("#{Rails.root.to_s}/public#{public_filename}", :headers => false) do |row|
        add_concentration(row[0], row[1]) #Each row is a concentration
      end
    end
  end
  
  private
  def add_concentration(name, value)
    if name.length > 0
      met = Metabolite.find(:first, :conditions => "name = '#{name}'")
    
      if met != nil
        c = Concentration.new()
        c.concentration_value = value
        c.metabolite = met
        c.data_file = self
        c.save!
      else
        #TODO: Do something here to show the user the error
        puts "METABOLITE NOT FOUND! #{name}"
      end
    end   
  end
  
end
