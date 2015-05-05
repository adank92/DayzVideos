class AddUploadedAtToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :uploaded_at, :datetime
  end
end
