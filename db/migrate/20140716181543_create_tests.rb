class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :loinc
      t.string :test_group
      t.string :test_code
      t.string :test_name
      t.string :specimen_source

      t.timestamps
    end
  end
end
