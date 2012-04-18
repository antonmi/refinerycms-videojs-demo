# This migration comes from refinery_videos (originally 11)
class RemovePositionFromVideoFile < ActiveRecord::Migration

  def change
    remove_column :refinery_video_files, :position
  end

end
