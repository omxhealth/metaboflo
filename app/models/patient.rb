class Patient < ActiveRecord::Base
  has_many :samples, :dependent => :destroy
  
  has_many :cohort_assignments, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  validates_presence_of :code
  validates_numericality_of :height, :weight, :greater_than => 0, :allow_blank => true
  validates_inclusion_of :gender, :in => ['Male', 'Female'], :allow_blank => true, :message => 'must be either Male or Female'
  
  def name
    "#{self.first_name} #{self.middle_name} #{self.last_name}".gsub(/\s+/, " ").strip
  end
end
