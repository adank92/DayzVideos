class ChangeUploaderToUserReferenceFromVideos < ActiveRecord::Migration
  def up
    rename_column :videos, :uploader, :user_id
    change_column :videos, :user_id, :integer
  end

  def down
    change_column :videos, :user_id, :string
    rename_column :videos, :user_id, :uploader
  end
end
