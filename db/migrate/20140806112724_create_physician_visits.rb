class CreatePhysicianVisits < ActiveRecord::Migration
  def change
    create_table :physician_visits do |t|
      t.integer :physician_id
      t.integer :visit_id

      t.timestamps
    end
  end
end
