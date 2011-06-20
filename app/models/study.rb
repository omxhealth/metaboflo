class Study < ActiveRecord::Base
  has_many :cohorts
  validates_presence_of :name
  
  accepts_nested_attributes_for :cohorts, :allow_destroy => true, :reject_if => :all_blank
end