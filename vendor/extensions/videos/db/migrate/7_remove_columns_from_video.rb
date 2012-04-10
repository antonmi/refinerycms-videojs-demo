class RemoveColumnsFromVideo < ActiveRecord::Migration

  def change
    remove_column :refinery_videos, :file_name, :file_size, :file_ext, :file_uid, :file_mime_type
  end

end

