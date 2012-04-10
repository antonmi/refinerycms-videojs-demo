require 'dragonfly'

module Refinery
  module Videos
    class VideoFile < Refinery::Core::BaseModel
      self.table_name = 'refinery_video_files'
      acts_as_indexed :fields => [:file_name, :file_ext]
      attr_accessible :file
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
      #######################################

      def title
        CGI::unescape(file_name.to_s).gsub(/\.\w+$/, '').titleize
      end

      class << self
        # How many resources per page should be displayed?
        #def per_page(dialog = false)
        #  dialog ? Resources.pages_per_dialog : Resources.pages_per_admin_index
        #end

        def create_resources(params)
          resources = []

          unless params.present? and params[:file].is_a?(Array)
            resources << create(params)
          else
            params[:file].each do |resource|
              resources << create(:file => resource)
            end
          end

          resources
        end

      end

    end
  end
end
