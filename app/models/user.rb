class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :encryptable, :encryptor => :sha1
 
  # Setup accessible attributes
  attr_accessible :email, :password, :password_confirmation, :name, :site_id, :rank
  
  belongs_to :site
  
  has_one :user_picture
  has_many :tasks, :foreign_key => 'assigned_to_id'
  has_many :samples, :foreign_key => 'collected_by_id'

  def to_s
    self.email
  end
end
