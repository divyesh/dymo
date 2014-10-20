class AddLocationIdToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :location_id, :integer
  end
end
