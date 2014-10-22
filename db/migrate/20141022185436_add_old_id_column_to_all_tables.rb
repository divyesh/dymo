class AddOldIdColumnToAllTables < ActiveRecord::Migration
  def self.up
    add_column :patients, :old_id, :integer
    add_column :physicians, :old_id, :integer
    add_column :physician_visits, :old_id, :integer
    add_column :test_groups, :old_id, :integer
    add_column :tests, :old_id, :integer
    add_column :token_histories, :old_id, :integer
    add_column :users, :old_id, :integer
    add_column :visit_tests, :old_id, :integer
    
    add_column :visits, :old_id, :integer
    add_column :tokens, :old_id, :integer
  end
  
  def self.down
    remove_column :patients, :old_id
    remove_column :physicians, :old_id
    remove_column :physician_visits, :old_id
    remove_column :test_groups, :old_id
    remove_column :tests, :old_id
    remove_column :token_histories, :old_id
    remove_column :users, :old_id
    remove_column :visit_tests, :old_id
    
    remove_column :visits, :old_id
    remove_column :tokens, :old_id
  end
end

