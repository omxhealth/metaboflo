class Experiment < ActiveRecord::Base
  belongs_to :sample
  has_many :data_files
  
  validates_presence_of :sample_id
end
