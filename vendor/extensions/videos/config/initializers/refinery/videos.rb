Refinery::Videos.configure do |config|
  # Configures the maximum allowed upload size (in bytes) for an image
  # config.max_image_size = 5242880

  # Configure how many images per page should be displayed when a dialog is presented that contains images
  # config.pages_per_dialog = 18

  # Configure how many images per page should be displayed when a dialog is presented that
  # contains images and image resize options
  # config.pages_per_dialog_that_have_size_options = 12

  # Configure how many videoss per page should be displayed in the list of images in the admin area
  config.pages_per_admin_index = 20
  config.pages_per_dialog = 7

  # Configure image sizes
  # config.user_image_sizes = {:small=>"110x110>", :medium=>"225x255>", :large=>"450x450>"}

  # Configure white-listed mime types for validation
  config.whitelisted_mime_types = %w(video/mp4 video/x-flv application/ogg video/webm)
  # Configure image view options
  # config.image_views = [:grid, :list]

  # Configure default image view
  # config.preferred_image_view = :grid

  # Configure S3 (you can also use ENV for this)
  # The s3_backend setting by default defers to the core setting for this but can be set just for images.
  # config.s3_backend = Refinery::Core.s3_backend
  # config.s3_bucket_name = ENV['S3_BUCKET']
  # config.s3_access_key_id = ENV['S3_KEY']
  # config.s3_secret_access_key = ENV['S3_SECRET']
  # config.s3_region = ENV['S3_REGION]

  # Configure Dragonfly
  # This is where in the middleware stack to insert the Dragonfly middleware
  # config.dragonfly_insert_before = "ActionDispatch::Callbacks"
  # config.dragonfly_secret = "3f6ce118b548a8fd0cc178fab4e9d86038a8f8cb69b8337b"
  # If you decide to trust file extensions replace :ext below with :format
  # config.dragonfly_url_format = "/system/images/:job/:basename.:ext"
  # config.datastore_root_path = "/home/antonmi/rails_projects/refinery_exp/public/system/refinery/images"
  # config.trust_file_extensions = false

end
