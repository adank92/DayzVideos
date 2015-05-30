class ChangeUploaderToUserReferenceFromVideos < ActiveRecord::Migration
  def up
    rename_column :videos, :uploader, :user_id
    change_column :videos, :user_id, 'integer USING CAST(user_id AS integer)'
  end

  def down
    change_column :videos, :user_id, 'string USING CAST(user_id AS string)'
    rename_column :videos, :user_id, :uploader
  end
end
