class AddVotesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :votes, :integer
  end
end
