class AddProvinceToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :province, :string
  end

  def self.down
    remove_column :physicians, :province
  end
end
