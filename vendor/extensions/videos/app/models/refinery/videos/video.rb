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

      attr_accessible :title, :poster_id, :video_files_attributes,
                      :position, :config, :embed_tag, :use_shared,
                      *CONFIG_OPTIONS.keys

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
        if use_shared
          update_from_config
          return embed_tag.html_safe
        end

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


      def index_short_info
        return "Shared Source" if use_shared
        info = []
        video_files.each do |file|
          if file.use_external
            info << "Link: #{file.external_url.scan(/\.(.+$)/).flatten.first}"
          else
            info << "File: #{file.mime_type.split('/').last}"
          end
        end

        info.join(' | ')
      end

      ####################################class methods
      class << self
        def per_page(dialog = false)
          dialog ? Videos.pages_per_dialog : Videos.pages_per_admin_index
        end
      end
      #################################################

      private

      def set_default_config
        CONFIG_OPTIONS.each do |option, value|
          self.send("#{option}=", value)
        end if new_record?
      end

      def update_from_config
        embed_tag.gsub!(/width="(\d*)?"/, "width=\"#{config[:width]}\"")
        embed_tag.gsub!(/height="(\d*)?"/, "height=\"#{config[:height]}\"")
      end


    end

  end
end
