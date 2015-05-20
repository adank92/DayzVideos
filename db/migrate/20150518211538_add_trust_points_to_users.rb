class AddTrustPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trust_points, :integer, default: 0
  end
end
