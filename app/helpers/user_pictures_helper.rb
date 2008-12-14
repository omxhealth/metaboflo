module UserPicturesHelper
  
  def small_picture(user_picture)
    return image_tag(user_picture.public_filename, :size => '60x80')
  end
  
  def large_picture(user_picture)
    return image_tag(user_picture.public_filename, :size => '120x160')
  end
  
end
