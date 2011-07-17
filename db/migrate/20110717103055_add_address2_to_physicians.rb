class AddAddress2ToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :address2, :string
  end

  def self.down
    remove_column :physicians, :address2
  end
end
