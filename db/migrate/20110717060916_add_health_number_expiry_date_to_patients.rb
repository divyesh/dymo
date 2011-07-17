class AddHealthNumberExpiryDateToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :health_expiry_date, :date
  end

  def self.down
    remove_column :patients, :health_expiry_date
  end
end
