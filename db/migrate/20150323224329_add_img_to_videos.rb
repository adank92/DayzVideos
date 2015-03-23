class AddImgToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :img, :string
  end
end
