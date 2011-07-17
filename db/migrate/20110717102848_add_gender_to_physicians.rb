class AddGenderToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :gender, :string
  end

  def self.down
    remove_column :physicians, :gender
  end
end
