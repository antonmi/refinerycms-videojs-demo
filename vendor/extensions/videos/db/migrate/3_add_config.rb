class AddConfig < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :config, :string
  end

end
