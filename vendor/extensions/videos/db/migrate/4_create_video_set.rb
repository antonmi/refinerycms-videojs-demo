class CreateVideoSet < ActiveRecord::Migration

  def up
    create_table :refinery_video_sets do |t|
      t.string :name
      t.string :config
      t.integer :poster_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    drop_table :refinery_video_sets
  end

end
