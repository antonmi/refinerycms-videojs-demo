# This migration comes from refinery_videos (originally 5)
class AddTitleToVideo < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :title, :string
  end

end
