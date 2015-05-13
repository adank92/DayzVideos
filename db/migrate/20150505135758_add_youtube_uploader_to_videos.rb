class AddYoutubeUploaderToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :youtube_uploader, :string
  end
end
