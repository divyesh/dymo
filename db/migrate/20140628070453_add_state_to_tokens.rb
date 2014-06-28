class AddStateToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :state, :string
  end
end
