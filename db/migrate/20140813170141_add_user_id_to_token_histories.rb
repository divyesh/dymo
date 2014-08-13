class AddUserIdToTokenHistories < ActiveRecord::Migration
  def change
    add_column :token_histories, :user_id, :integer
  end
end
