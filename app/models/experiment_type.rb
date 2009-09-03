class ExperimentType < ActiveRecord::Base
  has_many :experiments
  
  validates_presence_of :name
end
