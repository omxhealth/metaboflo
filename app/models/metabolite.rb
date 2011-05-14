class Metabolite < ActiveRecord::Base
  has_many :concentrations
  
  #Return an array of statistics describing concentrations for this metabolite
  def concentration_statistics
    stats = Array.new
    
    results = self.concentrations.select('concentration_units, avg(concentration_value) as average_concentration, std(concentration_value) std_concentration').
      group('concentration_units')
    
    results.each do |r|
      stats << "#{r.average_concentration.round(2)} &#177; #{r.std_concentration.round(2)} #{r.concentration_units}"
    end
    stats
  end
  
end
