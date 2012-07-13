class Protocol < ActiveRecord::Base
  has_attached_file :storage, :url => "/system/:attachment/:id/:filename", :path => ":rails_root/public/system/:attachment/:id/:filename"
  
  has_many :experiments
  validates_presence_of :name

  def to_label
    "#{self.name} (version #{self.version})"
  end
end
