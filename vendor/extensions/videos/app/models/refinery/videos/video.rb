require 'dragonfly'

module Refinery
  module Videos
    class Video < Refinery::Core::BaseModel

      self.table_name = 'refinery_videos'
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true

      has_many :video_files,:dependent => :destroy
      accepts_nested_attributes_for :video_files

      belongs_to :poster, :class_name => '::Refinery::Image'
      accepts_nested_attributes_for :poster

      ################## Video config options
      serialize :config, Hash
      CONFIG_OPTIONS = {
          :autoplay => "false", :width => "400", :height => "300",
          :controls => "true", :preload => "true", :loop => "true"
      }
      attr_accessible :title, :poster_id, :video_files_attributes, :position, :config, *CONFIG_OPTIONS.keys

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

      ########################### Callbacks
      after_initialize :set_default_config
      #####################################

      def to_html
        data_setup = []
        CONFIG_OPTIONS.keys.each do |option|
          if option && (option != :width && option != :height)
            data_setup << "\"#{option}\": #{config[option] || '\"auto\"'}"
          end
        end
        data_setup << "\"poster\": \"#{poster.url}\"" if poster
        sources = []
        video_files.each do |file|
          sources << ["<source src='#{file.url}' type='#{file.mime_type}'/>"]
        end
        html = %Q{<video id="video_#{self.id}" class="video-js vjs-default-skin" width="#{config[:width]}" height="#{config[:height]}" data-setup=' {#{data_setup.join(',')}}'>#{sources.join}</video>}
        html.html_safe
      end

      def build_video_files
        if new_record?
          Refinery::Videos.config[:whitelisted_mime_types].each do |type|
            video_file = VideoFile.new(:file_mime_type => type)
            self.video_files << video_file
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
