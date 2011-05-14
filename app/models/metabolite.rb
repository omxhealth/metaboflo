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
    
    # unit_concs = Hash.new
    # concentrations.each do |c|
    #   unit = c.concentration_units
    #   value = c.concentration_value
    #   unit_concs[unit] ||= Array.new
    #   unit_concs[unit] << value
    # end
    # 
    # unit_concs.keys.each do |unit|
    #   stats << "33 #{unit}"
    # end
    # 
    # stats
  end
  
end
