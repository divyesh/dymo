class AddMobileToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :mobile, :string
  end

  def self.down
    remove_column :patients, :mobile
  end
end
