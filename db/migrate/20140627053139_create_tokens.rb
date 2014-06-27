class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :no
      t.integer :patient_id

      t.timestamps
    end
  end
end
