class AddAddress2ToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :address2, :string
  end

  def self.down
    remove_column :patients, :address2
  end
end
