class RenameTestGroupToTestGroupOld < ActiveRecord::Migration
  def self.up
    rename_column :tests, :test_group, :test_group_old
  end

  def self.down
    rename_column :tests, :test_group_old, :test_group
  end
end
