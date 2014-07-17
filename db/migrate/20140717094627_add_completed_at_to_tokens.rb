class AddCompletedAtToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :completed_at, :datetime
  end
end
