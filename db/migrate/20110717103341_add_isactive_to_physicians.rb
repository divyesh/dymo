class AddIsactiveToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :isactive, :bool
  end

  def self.down
    remove_column :physicians, :isactive
  end
end
