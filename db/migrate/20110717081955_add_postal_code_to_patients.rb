class AddPostalCodeToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :postal_code, :string
  end

  def self.down
    remove_column :patients, :postal_code
  end
end
