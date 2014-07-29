class AddAmountToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :amount, :float
  end
end
