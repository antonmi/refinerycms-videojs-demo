class AddPosterToVideo < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :poster_id, :integer
  end

end
