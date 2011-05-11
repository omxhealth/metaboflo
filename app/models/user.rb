class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :encryptable, :encryptor => :sha1
 
  # Setup accessible attributes
  # attr_accessible :email, :password, :password_confirmation, :name, :site_id, :rank
  attr_protected :current_password
  
  belongs_to :site
  
  has_one :photo_file, :class_name => 'StoredFile::Photo', :as => :attachable
  accepts_nested_attributes_for :photo_file, :allow_destroy => true
  
  has_many :tasks, :foreign_key => 'assigned_to_id'
  has_many :samples, :foreign_key => 'collected_by_id'

  def to_s
    self.email
  end
end
