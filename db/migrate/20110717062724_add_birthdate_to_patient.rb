class AddBirthdateToPatient < ActiveRecord::Migration
  def self.up
    add_column :patients, :birthdate, :date
  end

  def self.down
    remove_column :patients, :birthdate
  end
end
