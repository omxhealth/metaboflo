class StoredFile::Photo < StoredFile
  has_attached_file :attachment, :url => "/system/:attachment/:id/:filename", :path => ":rails_root/public/system/:attachment/:id/:filename", :styles => { :thumb => ["100x100>", :png] }
  validates_attachment_content_type :attachment, :content_type => [ 'image/png', 'image/jpeg' ], :message => 'must be an image in png or jpeg format'
end
