class AddLocationIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :location_id, :integer
  end
end
