class AddGroupIndexToTest < ActiveRecord::Migration
  def change
    add_column :tests, :group_index, :string
  end
end
