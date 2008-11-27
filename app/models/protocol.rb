class Protocol < ActiveRecord::Base
  has_attachment :storage => :file_system, :path_prefix => 'public/files', :max_size => 200.megabytes
  validates_as_attachment
  
  has_many :experiments
  validates_presence_of :name
end
