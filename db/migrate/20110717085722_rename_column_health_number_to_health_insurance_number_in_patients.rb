class RenameColumnHealthNumberToHealthInsuranceNumberInPatients < ActiveRecord::Migration
  def self.up
    rename_column :patients, :healthnumber, :health_insurance_number
  end

  def self.down
    rename_column :patients, :health_insurance_number, :healthnumber
  end
end
