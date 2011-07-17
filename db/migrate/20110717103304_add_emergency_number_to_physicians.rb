class AddEmergencyNumberToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :emergency_number, :string
  end

  def self.down
    remove_column :physicians, :emergency_number
  end
end
