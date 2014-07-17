class CreateVisitTests < ActiveRecord::Migration
  def change
    create_table :visit_tests do |t|
      t.integer :visit_id
      t.integer :test_id

      t.timestamps
    end
  end
end
