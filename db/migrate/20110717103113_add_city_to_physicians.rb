class AddCityToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :city, :string
  end

  def self.down
    remove_column :physicians, :city
  end
end
