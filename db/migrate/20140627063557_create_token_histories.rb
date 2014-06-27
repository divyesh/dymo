class CreateTokenHistories < ActiveRecord::Migration
  def change
    create_table :token_histories do |t|
      t.integer :token_id
      t.datetime :punch_in_time
      t.string :note

      t.timestamps
    end
  end
end
