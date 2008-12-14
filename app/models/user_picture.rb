class UserPicture < ActiveRecord::Base

  belongs_to :user
  
  has_attachment :storage => :file_system, :path_prefix => 'public/files', :max_size => 10.megabytes
  validates_as_attachment
  
end
