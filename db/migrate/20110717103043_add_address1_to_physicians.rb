class AddAddress1ToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :address1, :string
  end

  def self.down
    remove_column :physicians, :address1
  end
end
