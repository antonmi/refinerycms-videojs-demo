# This migration comes from refinery_videos (originally 1)
class CreateVideosVideos < ActiveRecord::Migration

  def up
    create_table :refinery_videos do |t|
      t.string :file_name
      t.integer :file_size
      t.string :file_ext
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-videos"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/videos/videos"})
    end

    drop_table :refinery_videos

  end

end
