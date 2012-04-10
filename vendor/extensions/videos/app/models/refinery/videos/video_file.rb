require 'dragonfly'

module Refinery
  module Videos
    class VideoFile < Refinery::Core::BaseModel
      MIME_TYPES = %w(video/mp4 video/x-flv application/ogg video/webm)
      self.table_name = 'refinery_video_files'
      acts_as_indexed :fields => [:file_name, :file_ext]
      attr_accessible :file, :file_mime_type, :position
      belongs_to :video

      ############################ Dragonfly
      ::Refinery::Videos::Dragonfly.setup!
      video_accessor :file

      delegate :ext, :size, :mime_type, :url,
               :to        => :file,
               :allow_nil => true

      #######################################

      ########################### Validations
      validates :file_name, :presence => true, :uniqueness => true
      validates :file, :presence => true
      validates :mime_type, :inclusion => { :in => MIME_TYPES,
                                            :message => "Wrong file mime_type" }
      #######################################

      def title
        CGI::unescape(file_name.to_s).gsub(/\.\w+$/, '').titleize
      end

    end
  end
end
