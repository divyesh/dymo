class AddVisibleInListToTests < ActiveRecord::Migration
  def change
    add_column :tests, :visible_in_list, :boolean, default: true
  end
end
