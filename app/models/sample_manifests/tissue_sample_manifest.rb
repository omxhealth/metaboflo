class TissueSampleManifest < ActiveRecord::Base
  belongs_to :sample_manifest

  def tests
    
    total = 0
    total += 1 if self.module_1
    total += 1 if self.module_2
    total += 1 if self.module_3
    total += 1 if self.module_4
    total += 1 if self.module_5
    total += 1 if self.module_6
    total += 1 if self.module_7
    total += 1 if self.module_8
    total += 1 if self.module_9
    total += 1 if self.module_10
    total += 1 if self.module_11
    total += 1 if self.module_12
    
    total
  end
  
  def estimate
    total = 0
    total += 90 if self.module_1
    total += 90 if self.module_2
    total += 90 if self.module_3
    total += 90 if self.module_4
    total += 90 if self.module_5
    total += 90 if self.module_6
    total += 125 if self.module_7
    total += 90 if self.module_8
    total += 90 if self.module_9
    total += 90 if self.module_10
    total += 90 if self.module_11
    total += 90 if self.module_12
    
    total
    
  end
  
    # Returns a boolean if all required information is present
  def required_fields_present?
    !self.species.blank? && !self.tissue_weight.blank? &&
    !self.matrix.blank? && !self.weight_units.blank? && !self.group_id.blank?
  end
  
  def to_s
    "#{self.class.to_s}: Tube Id - #{self.tube_id} Species - #{self.species} Tissue - #{self.matrix} " + 
    "Group # - #{self.group_id} Weight - #{self.tissue_weight}#{self.weight_units} Modules - #{modules.join(',')}"
  end
  
  def modules
    
    modules = []
    modules << "1" if self.module_1
    modules << "2" if self.module_2
    modules << "3" if self.module_3
    modules << "4" if self.module_4
    modules << "5" if self.module_5
    modules << "6" if self.module_6
    modules << "7" if self.module_7
    modules << "8" if self.module_8
    modules << "9" if self.module_9
    modules << "10" if self.module_10
    modules << "11" if self.module_11
    modules << "12" if self.module_12
    modules
  end
  
end