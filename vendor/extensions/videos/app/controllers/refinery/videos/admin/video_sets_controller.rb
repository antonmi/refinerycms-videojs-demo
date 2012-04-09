module Refinery
  module Videos
    module Admin
      class VideoSetsController < ::Refinery::AdminController

        crudify :'refinery/videos/video_set',
                :title_attribute => 'name', :xhr_paging => true

        def new
          @video_set = VideoSet.new
          @video_set.videos.build
        end

      end
    end
  end
end