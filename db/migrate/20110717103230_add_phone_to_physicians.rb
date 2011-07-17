class AddPhoneToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :phone, :string
  end

  def self.down
    remove_column :physicians, :phone
  end
end
