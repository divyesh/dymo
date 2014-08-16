class AddPositionToTests < ActiveRecord::Migration
  def change
    add_column :tests, :position, :integer, default: 0
  end
end
