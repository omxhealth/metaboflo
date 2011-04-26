class Experiment < ActiveRecord::Base
  belongs_to :assigned_to, :class_name => 'User'
  belongs_to :performed_by, :class_name => 'User'
  
  belongs_to :sample
  belongs_to :protocol
  belongs_to :experiment_type

  has_many :data_files, :dependent => :destroy
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  validates_presence_of :sample_id, :name, :experiment_type_id
  
  validates_numericality_of :amount_used, :greater_than_or_equal => 0, :allow_blank => true
  
  # Required so that Experiments, Samples, and TestSubjects can be displayed in cohorts
  def to_s
    return "#{self.name} (#{self.experiment_type.name})"
  end
  
  def short_description(max_length = 50)
    if (description and
        description.length > max_length)
      "#{description[0..max_length]}..."
    else
      description
    end
  end
  
  def root
    sample.root
  end
  
end
