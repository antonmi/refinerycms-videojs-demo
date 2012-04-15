# This migration comes from refinery_videos (originally 10)
class AddUseSharedVideoToVideo < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :use_shared, :boolean
    add_column :refinery_videos, :embed_tag, :text
  end

end
