Refinery::Videos.configure do |config|
    #Configures the maximum allowed upload size (in bytes) for an video file
    config.max_file_size = 10_000_000

    # Configure how many videos per page should be displayed in the list of images in the admin area
    #config.pages_per_admin_index =  20
    #config.pages_per_dialog = 7

    # Configure white-listed mime types for validation
    #config.whitelisted_mime_types = ["video/mp4", "video/x-flv", "application/ogg", "video/webm", "video/flv", "video/ogg"]


    # Configure Dragonfly
    # This is where in the middleware stack to insert the Dragonfly middleware
    # config.dragonfly_insert_before = ActionDispatch::Callbacks
    # config.dragonfly_secret = 29fd27d942cc43710965020121ca65f1e643f9413340cb97
    # If you decide to trust file extensions replace :ext below with :format
    # config.dragonfly_url_format = /system/videos/:job/:basename.:format
    # config.datastore_root_path = /home/antonmi/rails_projects/refinerycms-videojs-demo/public/system/refinery/videos
    # config.trust_file_extensions = false

end
