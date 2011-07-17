class AddPostalCodeToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :postal_code, :string
  end

  def self.down
    remove_column :physicians, :postal_code
  end
end
