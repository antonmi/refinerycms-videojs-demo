class AddVideoSetId < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :video_set_id, :integer
  end

end
