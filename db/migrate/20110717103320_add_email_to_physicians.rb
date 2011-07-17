class AddEmailToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :email, :string
  end

  def self.down
    remove_column :physicians, :email
  end
end
