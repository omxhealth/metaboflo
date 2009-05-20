class Site < ActiveRecord::Base
  has_many :users
  has_many :test_subjects, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
