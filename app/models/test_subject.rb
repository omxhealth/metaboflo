class TestSubject < ActiveRecord::Base
  TITLE = 'Test Subject'
  
  belongs_to :site
  
  has_many :samples, :dependent => :destroy
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  has_many :medications, :dependent => :destroy
  has_many :test_subject_evaluations, :dependent => :destroy
  has_many :lab_tests, :order => 'collected_at ASC', :dependent => :destroy
  
  has_many :meals, :order => 'consumed_during_period ASC, consumed_on_day ASC', :dependent => :destroy
  has_many :diets, :through => :meals
  
  validates_presence_of :code, :site_id
  
  def name
    "#{TITLE} #{code}"
  end
  
  def to_s
    self.code.to_s
  end
  
  def features
    return {'1-methylhistidine' => 0.43, 'urea' => 455.215}
  end
  
  def TestSubject.title
    TITLE
  end
end
