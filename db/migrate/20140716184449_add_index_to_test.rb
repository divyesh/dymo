class AddIndexToTest < ActiveRecord::Migration
  def change
    add_column :tests, :index, :string
  end
end
