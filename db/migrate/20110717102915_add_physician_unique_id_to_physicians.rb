class AddPhysicianUniqueIdToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :physician_unique_id, :string
  end

  def self.down
    remove_column :physicians, :physician_unique_id
  end
end
