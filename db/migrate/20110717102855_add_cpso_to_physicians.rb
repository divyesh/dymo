class AddCpsoToPhysicians < ActiveRecord::Migration
  def self.up
    add_column :physicians, :cpso, :string
  end

  def self.down
    remove_column :physicians, :cpso
  end
end
