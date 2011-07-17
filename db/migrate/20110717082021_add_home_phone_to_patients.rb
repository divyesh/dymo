class AddHomePhoneToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :home_phone, :string
  end

  def self.down
    remove_column :patients, :home_phone
  end
end
