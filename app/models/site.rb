class Site < ActiveRecord::Base
  has_many :patients
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
