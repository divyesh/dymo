class AddVisitDateToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :visitdate, :datetime
  end
end
