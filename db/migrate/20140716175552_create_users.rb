class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :middlename
      t.string :username

      t.timestamps
    end
  end
end
