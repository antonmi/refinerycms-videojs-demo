# This migration comes from refinery_videos (originally 2)
class AddFileUid < ActiveRecord::Migration

  def change
    add_column :refinery_videos, :file_uid, :string
    add_column :refinery_videos, :file_mime_type, :string
  end

end
