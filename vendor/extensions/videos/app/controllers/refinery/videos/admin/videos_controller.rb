module Refinery
  module Videos
    module Admin
      class VideosController < ::Refinery::AdminController

        crudify :'refinery/videos/video',
                :title_attribute => 'title', :xhr_paging => true

        before_filter :set_mime_types, :only => [:new, :edit, :create, :update]

        def show
          @video = Video.find(params[:id])
        end

        def new
          @video = Video.new
          @video.video_files.build
        end

        def insert
          @videos = Video.all
        end

        def append_to_wym
          @video = Video.find(params[:id])
          @html_for_wym = @video.to_html
        end

        def set_mime_types
          @mime_types = Refinery::Videos.config[:whitelisted_mime_types]
        end


      end
    end
  end
end
