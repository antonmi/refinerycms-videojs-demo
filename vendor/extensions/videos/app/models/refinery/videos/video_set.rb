require 'dragonfly'

module Refinery
  module Videos
    class VideoSet < Refinery::Core::BaseModel
      self.table_name = 'refinery_video_sets'
      acts_as_indexed :fields => [:name]
      has_many :videos, :dependent => :destroy
      accepts_nested_attributes_for :videos

      belongs_to :poster, :class_name => '::Refinery::Image'
      accepts_nested_attributes_for :poster

      ################## Video config options
      serialize :config, Hash
      CONFIG_OPTIONS = {
          :autoplay => "false", :width => "400", :height => "300",
          :controls => "true", :preload => "true",
          :poster => "false", :loop => "false"
      }
      attr_accessible :poster_id, :position, :name, :videos_attributes, :config, *CONFIG_OPTIONS.keys

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


      def to_html
        data_setup = []
        CONFIG_OPTIONS.keys.each do |option|
          if option && (option != :width && option != :height)
            data_setup << "\"#{option}\": #{config[option] || '\"auto\"'}"
          end
        end
        sources = ["<source src='#{self.url}' type='#{self.mime_type}'/>"]

        html = <<EOS
        <video id="example_video_1" class="video-js vjs-default-skin" width="#{config[:width]}" height="#{config[:height]}" data-setup=' {#{data_setup.join(',')}}'>#{sources.join}</video>
EOS
        html.html_safe
      end



      def set_default_config
        CONFIG_OPTIONS.each do |option, value|
          self.send("#{option}=", value)
        end if new_record?
      end


    end
  end
end
