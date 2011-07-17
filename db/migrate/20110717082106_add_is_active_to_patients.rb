class AddIsActiveToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :isactive, :bool
  end

  def self.down
    remove_column :patients, :isactive
  end
end
