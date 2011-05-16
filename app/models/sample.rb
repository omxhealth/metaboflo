class Sample < ActiveRecord::Base
  SAMPLE_TYPES = ['ruminal', 'blood', 'milk', 'urine', 'feces']
  
  belongs_to :test_subject
  belongs_to :sample
  belongs_to :site
  belongs_to :collected_by, :class_name => 'User'
  
  before_validation :assign_parent_type
  
  has_many :samples, :dependent => :destroy
  has_many :experiments, :dependent => :destroy
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  scope :location_contains, lambda {|name| where(['building like ? or room like ?', "%#{name}%", "%#{name}%"])}
  search_methods :location_contains
  
  validates_numericality_of :original_amount, :greater_than_or_equal => 0, :allow_blank => true
  # validates_inclusion_of :original_unit, :in => ['ml', 'g'], :allow_blank => true
  validates_numericality_of :actual_amount, :greater_than_or_equal => 0, :allow_blank => true
  # validates_inclusion_of :actual_unit, :in => ['ml', 'g'], :allow_blank => true

  validate :sample_chronology

  # belongs_to :collected_by, :class_name => 'User', :foreign_key => 'collected_by_id'
  
  # Required so that Experiments, Samples, and TestSubjects can be displayed in cohorts
  def to_s
    return "#{self.barcode.blank? ? 'No barcode' : self.barcode} (#{sample_type.blank? ? 'No sample type' : sample_type} - #{original_amount.blank? ? 'Unknown amount' : "#{original_amount} #{original_unit}"})"
  end
  
  def test_subject_code
    self.test_subject.code if self.test_subject
  end

  def test_subject_code=(code)
    self.test_subject = TestSubject.find_by_code(code) unless code.blank?
  end
  
  def sample_chronology
    if (test_subject and test_subject.birthdate and collected_on and test_subject.birthdate > collected_on)
      errors.add(:collected_on, "The sample cannot be taken before the #{TestSubject.title}'s birth date")
    end
  end

  def assign_parent_type
    self.sample_type = self.sample.sample_type if self.sample
  end
  
  def root
    current_sample = self
    while current_sample.test_subject.nil?
      current_sample = current_sample.sample
    end
    current_sample.test_subject
  end

  # calculates the theoretical amount of this sample = original amount - sum(original amount of each child)
  #
  # assumes that original_unit for this sample and all children are the same
  def theoretical_amount
    theoretical = self.original_amount.to_f
    self.samples.each do |child|
      theoretical -= child.original_amount.to_f
    end
    theoretical
  end
  
  def parent
    self.test_subject || self.sample
  end
  
  def aliquot?
    return !self.sample.blank?
  end
  
  # Return a list of all used sample types
  def Sample.sample_types
    self.select('DISTINCT sample_type').order(:sample_type).all.collect { |s| s.sample_type }
  end
  
  
end
