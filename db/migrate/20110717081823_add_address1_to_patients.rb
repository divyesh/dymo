class AddAddress1ToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :address1, :string
  end

  def self.down
    remove_column :patients, :address1
  end
end
