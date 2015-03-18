class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.string :uploader
      t.integer :duration

      t.timestamps null: false
    end
  end
end
