require 'dragonfly'

module Refinery
  module Videos
    class Video < Refinery::Core::BaseModel
      self.table_name = 'refinery_videos'
      acts_as_indexed :fields => [:file_name, :file_ext]

      ################## Video config options
      serialize :config, Hash
      CONFIG_OPTIONS = {
          :autoplay => "false", :width => "400", :height => "300",
          :controls => "true", :preload => "true",
          :poster => "false", :loop => "false"
      }
      attr_accessible :file, :config, *CONFIG_OPTIONS.keys

      # Create getters and setters
      CONFIG_OPTIONS.keys.each do |option|
        define_method option do
          self.config[option]
        end
        define_method "#{option}=" do |value|
          self.config[option] = value
        end
      end
      #######################################

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

      ########################### Callbacks
      after_initialize :set_default_config
      #####################################


      def title
        CGI::unescape(file_name.to_s).gsub(/\.\w+$/, '').titleize
      end

      def to_html
        data_setup = []
        CONFIG_OPTIONS.keys.each do |option|
          if option && (option != :width && option != :height && option != :controls)
            data_setup << "\"#{option}\": \"#{config[option]}\""
          end
        end
        sources = ["<source src='#{self.url}' type='#{self.mime_type}'/>"]

        html = <<EOS
        <video id="example_video_1" class="video-js vjs-default-skin" width="#{config[:width]}" height="#{config[:height]}" controls="#{config[:controls] || "auto"}" data-setup=' {#{data_setup.join(',')}}'>#{sources.join}</video>
EOS
        html.html_safe
      end

      class << self
        # How many resources per page should be displayed?
        #def per_page(dialog = false)
        #  dialog ? Resources.pages_per_dialog : Resources.pages_per_admin_index
        #end

        def create_resources(params)
          add_config!(params)
          resources = []

          unless params.present? and params[:file].is_a?(Array)
            resources << create(params)
          else
            params[:file].each do |resource|
              resources << create(:file => resource, :config => params[:config])
            end
          end

          resources
        end

        def add_config!(params)
          params.merge!(:config => {})
          CONFIG_OPTIONS.keys.each do |option|
            params[:config].merge!(option => params[option])
          end
        end
      end

      private

      def set_default_config
        CONFIG_OPTIONS.each do |option, value|
           self.send("#{option}=", value)
        end if new_record?
      end

    end
  end
end
