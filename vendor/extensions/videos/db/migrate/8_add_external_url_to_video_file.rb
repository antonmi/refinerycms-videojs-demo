class AddExternalUrlToVideoFile < ActiveRecord::Migration

  def change
    add_column :refinery_video_files, :external_url, :string
    add_column :refinery_video_files, :use_external, :boolean
  end

end
