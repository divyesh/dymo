class AddPatientUniqueIdToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :patient_unique_id, :string
  end

  def self.down
    remove_column :patients, :patient_unique_id
  end
end
