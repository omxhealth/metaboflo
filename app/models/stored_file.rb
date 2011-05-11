class StoredFile < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
  has_attached_file :attachment, :url => "/system/:attachment/:id/:filename", :path => ":rails_root/public/system/:attachment/:id/:filename"
end
