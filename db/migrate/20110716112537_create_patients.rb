class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :healthnumber

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
