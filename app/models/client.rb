class Client < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, 
          :lockable,  :registerable
 
  # Setup accessible attributes
  # attr_accessible :email, :password, :password_confirmation, :name, :site_id, :rank
  attr_protected :current_password
  
  has_many :samples
  has_many :sample_manifests
  
  #validates :name, :presence => true
  
  def to_s
    self.email
  end
end
