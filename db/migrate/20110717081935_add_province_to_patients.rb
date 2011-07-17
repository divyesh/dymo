class AddProvinceToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :province, :string
  end

  def self.down
    remove_column :patients, :province
  end
end
