class AddCountryToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :country, :string
  end

  def self.down
    remove_column :physicians, :country
  end
end
