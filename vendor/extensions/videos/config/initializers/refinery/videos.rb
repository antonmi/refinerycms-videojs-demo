Refinery::Videos.configure do |config|
  # Configures the maximum allowed upload size (in bytes) for an video file
  #config.max_file_size = 5242

  # Configure how many videos per page should be displayed in the list of images in the admin area
  #config.pages_per_admin_index = 20
  #config.pages_per_dialog = 7

  # Configure white-listed mime types for validation
  #config.whitelisted_mime_types = %w(video/mp4 video/x-flv application/ogg video/webm)


  # Configure Dragonfly
  # This is where in the middleware stack to insert the Dragonfly middleware
  # config.dragonfly_insert_before = "ActionDispatch::Callbacks"
  # config.dragonfly_secret = "3f6ce118b548a8fd0cc178fab4e9d86038a8f8cb69b8337b"
  # If you decide to trust file extensions replace :ext below with :format
  # config.dragonfly_url_format = "/system/images/:job/:basename.:ext"
  # config.datastore_root_path = "/home/antonmi/rails_projects/refinery_exp/public/system/refinery/images"
  # config.trust_file_extensions = false

end
