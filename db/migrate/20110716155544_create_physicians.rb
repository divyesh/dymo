class CreatePhysicians < ActiveRecord::Migration
  def self.up
    create_table :physicians do |t|
      t.string :physician_number
      t.string :firstname
      t.string :middlename
      t.string :lastname

      t.timestamps
    end
  end

  def self.down
    drop_table :physicians
  end
end
