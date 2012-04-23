module Refinery
  class VideoGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_videos_initializer
      template "config/initializers/refinery/videos.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "videos.rb")
    end

  end
end
