# This migration comes from refinery_videos (originally 8)
class AddExternalUrlToVideoFile < ActiveRecord::Migration

  def change
    add_column :refinery_video_files, :external_url, :string
    add_column :refinery_video_files, :use_external, :boolean
  end

end
