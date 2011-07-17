class AddFaxToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :fax, :string
  end

  def self.down
    remove_column :physicians, :fax
  end
end
