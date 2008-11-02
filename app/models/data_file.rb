class DataFile < ActiveRecord::Base
  has_attachment :storage => :file_system, :path_prefix => 'public/files', :max_size => 200.megabytes
  validates_as_attachment
  validates_presence_of :data_file_type_id
  
  belongs_to :data_file_type
  belongs_to :experiment
end
