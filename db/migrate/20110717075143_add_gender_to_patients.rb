class AddGenderToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :gender, :string
  end

  def self.down
    remove_column :patients, :gender
  end
end
