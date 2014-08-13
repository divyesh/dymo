class AddLabNumberToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :lab_number, :string
  end
end
