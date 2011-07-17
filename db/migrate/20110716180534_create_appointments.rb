class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.integer :patient_id
      t.integer :physician_id
      t.datetime :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
