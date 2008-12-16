class UserPicture < ActiveRecord::Base

  belongs_to :user
  
  has_attachment :content_type => :image, :storage => :file_system, :path_prefix => 'public/files', :max_size => 5.megabytes
  #:resize_to => '180x240>'
  validates_as_attachment
  
end
