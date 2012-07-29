class TissueSampleManifest < ActiveRecord::Base
  belongs_to :sample_manifest

  def tests
    total = 0
    total += 1 if self.module_1
    total += 1 if self.module_2
    total += 1 if self.module_3
    total += 1 if self.module_4
    total += 1 if self.module_5
    total += 1 if self.gc_fap
    total += 1 if self.ss_1
    total += 1 if self.ss_2
    
    total
  end
  def estimate
    total = 0
    total += 90 if self.module_1
    total += 90 if self.module_2
    total += 90 if self.module_3
    total += 65 if self.module_4
    total += 90 if self.module_5
    total += 90 if self.gc_fap
    total += 90 if self.ss_1
    total += 90 if self.ss_2

    total
    
  end

end