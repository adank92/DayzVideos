class CreateVideoCategories < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.references :video, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :video_categories, :videos
    add_foreign_key :video_categories, :categories
  end
end
