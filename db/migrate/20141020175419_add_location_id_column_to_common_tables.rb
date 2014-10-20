class AddLocationIdColumnToCommonTables < ActiveRecord::Migration
  def self.up
    add_column :patients, :location_id, :integer
    add_column :physicians, :location_id, :integer
    add_column :physician_visits, :location_id, :integer
    add_column :test_groups, :location_id, :integer
    add_column :tests, :location_id, :integer
    add_column :token_histories, :location_id, :integer
    add_column :users, :location_id, :integer
    add_column :visit_tests, :location_id, :integer
  end
  
  def self.down
    remove_column :patients, :location_id
    remove_column :physicians, :location_id
    remove_column :physician_visits, :location_id
    remove_column :test_groups, :location_id
    remove_column :tests, :location_id
    remove_column :token_histories, :location_id
    remove_column :users, :location_id
    remove_column :visit_tests, :location_id
  end
end
