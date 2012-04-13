require 'dragonfly'

module Refinery
  module Videos
    class Video < Refinery::Core::BaseModel

      self.table_name = 'refinery_videos'
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true
      validate :one_source

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
      after_update :build_video_files
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
          if file.use_external
            sources << ["<source src='#{file.external_url}' type='#{file.file_mime_type}'/>"]
          else
            sources << ["<source src='#{file.url}' type='#{file.file_mime_type}'/>"]
          end if file.exist?
        end
        html = %Q{<video id="video_#{self.id}" class="video-js vjs-default-skin" width="#{config[:width]}" height="#{config[:height]}" data-setup=' {#{data_setup.join(',')}}'>#{sources.join}</video>}

        html.html_safe
      end

      def build_video_files
        Refinery::Videos.config[:whitelisted_mime_types].each do |type|
          unless video_files.map(&:file_mime_type).include?(type)
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

      def one_source
        if video_files.map(&:file).join.empty? && video_files.map(&:external_url).join.empty?
          errors.add(:video_files, "At least one source should present")
        end
      end

    end

  end
end
