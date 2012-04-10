# This migration comes from refinery_videos (originally 4)
class CreateVideoFile < ActiveRecord::Migration

  def up
    create_table :refinery_video_files do |t|
      t.string :file_name
      t.integer :file_size
      t.string :file_ext
      t.integer :position
      t.string :file_uid
      t.string :file_mime_type

      t.integer :video_id

      t.timestamps
    end

  end

  def down

    drop_table :refinery_videos

  end

end
