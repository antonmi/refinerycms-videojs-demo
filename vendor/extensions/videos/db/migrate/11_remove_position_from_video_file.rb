class RemovePositionFromVideoFile < ActiveRecord::Migration

  def change
    remove_column :refinery_video_files, :position
  end

end
