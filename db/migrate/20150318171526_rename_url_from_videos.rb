class RenameUrlFromVideos < ActiveRecord::Migration
  def change
    rename_column :videos, :url, :youtube_id
  end
end
