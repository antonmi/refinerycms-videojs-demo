require 'dragonfly'

module Refinery
  module Videos
    class Video < Refinery::Core::BaseModel
      CONFIG_OPTIONS = [:autoplay, :width, :height, :controls, :preload, :poster, :loop]
      ::Refinery::Videos::Dragonfly.setup!
      attr_accessible :id, :file, :config, *CONFIG_OPTIONS
      video_accessor :file
      serialize :config, Hash

      delegate :ext, :size, :mime_type, :url, :to => :file, :allow_nil => true

      #attr_accessor *CONFIG_OPTIONS
      #attr_accessible *CONFIG_OPTIONS

      CONFIG_OPTIONS.each do |option|
        define_method option do
          self.config[option]
        end
        define_method "#{option}=" do |value|
          self.config[option] = value
        end
      end


      #after_initialize :init_config
      #before_save :update_config


      self.table_name = 'refinery_videos'

      acts_as_indexed :fields => [:file_name, :file_ext]

      validates :file_name, :presence => true, :uniqueness => true
      validates :file, :presence => true

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

      private

      #def init_config
      #  CONFIG_OPTIONS.each do |option|
      #    self.send("#{option.to_s}=", config[option])
      #  end
      #end
      #
      #def update_config
      #  CONFIG_OPTIONS.each do |option|
      #    config[option] = self.send(option)
      #  end
      #end

    end
  end
end
