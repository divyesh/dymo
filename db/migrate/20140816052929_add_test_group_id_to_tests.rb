class AddTestGroupIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :test_group_id, :integer
  end
end
