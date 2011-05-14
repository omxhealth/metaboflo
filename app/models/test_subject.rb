class TestSubject < ActiveRecord::Base
  belongs_to :site
  
  has_many :samples, :dependent => :destroy
  accepts_nested_attributes_for :samples, :allow_destroy => true
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  has_many :medications, :dependent => :destroy
  has_many :test_subject_evaluations, :dependent => :destroy
  has_many :lab_tests, :order => 'collected_at ASC', :dependent => :destroy
  
  has_many :meals, :order => 'consumed_during_period ASC, consumed_on_day ASC', :dependent => :destroy
  has_many :diets, :through => :meals
  
  validates_presence_of :code, :site_id
  
  scope :with_site, lambda { |site_id| where(:site_id => site_id) } # Return all test subjects with the given site id
  
  def name
    "#{TestSubject.title} #{code}"
  end
  
  def to_s
    self.code.to_s
  end
  
  #Return a representative data file.
  def data_file
    files = DataFile.find(:all, :select => 'DISTINCT data_files.*', :conditions => ["data_files.has_concentrations = ? AND test_subjects.id = ?", true, self.id], :joins => { :experiment => { :sample => :test_subject  } })
    return files[0] #For now just return the first one
  end
  
  #Return features representing this test subject.
  def features
    df = self.data_file
    if df.nil?
      return Hash.new
    else
      feats = Hash.new
      df.concentrations.each do |c|
        if !c.metabolite.nil?
          feats[c.metabolite.name] = c.concentration_value
        end
      end
      return feats
    end
  end
  
  def TestSubject.title
    SUBJECT_CONFIG[:title]
  end
end
