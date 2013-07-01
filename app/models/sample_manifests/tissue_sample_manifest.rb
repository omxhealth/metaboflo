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
    total += 65 if self.module_4
    total += 90 if self.module_5
    total += 90 if self.module_6
    total += 90 if self.module_7
    total += 90 if self.module_8
    total += 90 if self.module_9
    total += 90 if self.module_10
    total += 90 if self.module_11
    total += 90 if self.module_12
    
    total
    
  end

end