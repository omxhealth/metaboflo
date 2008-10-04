class DataFileType < ActiveRecord::Base
  has_many :data_files
  
  validates_presence_of :name
end
