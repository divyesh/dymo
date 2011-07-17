class AddVersionCodeToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :version_code, :string
  end

  def self.down
    remove_column :patients, :version_code
  end
end
