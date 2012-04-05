module Refinery
  module Videos
    module Admin
      class VideosController < ::Refinery::AdminController

        crudify :'refinery/videos/video',
                :title_attribute => 'file_name', :xhr_paging => true


        def show
          @video = Video.find(params[:id]).dragonfly_attachments[:file].path.split('/public')[1]
        end


        def create
          @resources = Video.create_resources(params[:video])
          @resource = @resources.detect { |r| !r.valid? }

          unless params[:insert]
            if @resources.all?(&:valid?)
              flash.notice = t('created', :scope => 'refinery.crudify', :what => "'#{@resources.map(&:title).join("', '")}'")
              unless from_dialog?
                redirect_to refinery.admin_videos_path
              else
                @dialog_successful = true
                render :nothing => true, :layout => true
              end
            else
              self.new # important for dialogs
              render :action => 'new'
            end
          else
            if @resources.all?(&:valid?)
              @resource_id = @resources.detect(&:persisted?).id
              @resource = nil

              self.insert
            end
          end
        end

      end
    end
  end
end
