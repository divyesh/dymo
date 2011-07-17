class AddCityToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :city, :string
  end

  def self.down
    remove_column :patients, :city
  end
end
