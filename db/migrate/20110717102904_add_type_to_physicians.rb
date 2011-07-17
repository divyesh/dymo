class AddTypeToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :type, :string
  end

  def self.down
    remove_column :physicians, :type
  end
end
