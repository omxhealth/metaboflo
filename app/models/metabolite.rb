class Metabolite < ActiveRecord::Base
  has_many :concentrations
  
  # Parse and collect the pathways for this metabolite as an array of hashes
  def pathways
    return nil if self.pathways_before_type_cast.blank?
    
    results = Array.new
    self.pathways_before_type_cast.split(/\|/).each do |pw|
      if vals = pw.split(/:/)
        results << { :smpdb_id => vals[0], :name => vals[1] }
      end
    end
    results
  end
  
  # Return an array of statistics describing concentrations for this metabolite
  def concentration_statistics
    stats = Array.new
    
    results = self.concentrations.select('concentration_units, avg(concentration_value) as average_concentration, std(concentration_value) std_concentration').
      group('concentration_units')
    
    results.each do |r|
      stats << "<strong>Average:</strong> #{r.average_concentration.round(1)} #{r.concentration_units} (&sigma;=#{r.std_concentration.round(1)})"
    end
    stats
  end
  
end
