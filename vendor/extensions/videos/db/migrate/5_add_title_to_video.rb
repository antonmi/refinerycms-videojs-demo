class AddTitleToVideo < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :title, :string
  end

end
