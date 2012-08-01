class SampleManifest < ActiveRecord::Base
  belongs_to :client
  has_many :biofluid_sample_manifests, :dependent => :destroy
  has_many :tissue_sample_manifests, :dependent => :destroy
  has_many :cell_sample_manifests, :dependent => :destroy
  
  accepts_nested_attributes_for :biofluid_sample_manifests, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :tissue_sample_manifests, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :cell_sample_manifests, :allow_destroy => true, :reject_if => :all_blank
   
   
  def total_samples
    self.biofluid_sample_manifests.count + self.tissue_sample_manifests.count + self.cell_sample_manifests.count
  end 
  
  def total_tests
    total = 0
    self.biofluid_sample_manifests.each do |s|
      total += s.tests
    end
    self.tissue_sample_manifests.each do |s|
      total += s.tests
    end
    self.cell_sample_manifests.each do |s|
      total += s.tests
    end

    total
  end
  
  def estimate
    total = 0
    self.biofluid_sample_manifests.each do |s|
      total += s.estimate
    end
    self.tissue_sample_manifests.each do |s|
      total += s.estimate
    end
    self.cell_sample_manifests.each do |s|
      total += s.estimate
    end

    total
  end

  def self.module_codes(manifest)
    codes = []
    codes << "MP#1" if manifest.module_1?
    codes << "MP#2" if manifest.module_2?
    codes << "MP#3" if manifest.module_3?
    codes << "MP#4" if manifest.module_4?
    codes << "MP#5" if manifest.module_5?
    codes << "GC-FAP" if manifest.gc_fap?
    codes << "SS#1" if manifest.ss_1?
    codes << "SS#2" if manifest.ss_2?
    codes
  end
end