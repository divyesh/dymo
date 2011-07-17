class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :patient_id
      t.integer :physician_id

      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
