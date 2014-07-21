class AddSpecimenPriorityToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :specimen_priority, :string
  end
end
