class AddPayemntProgramToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :payment_program, :string
  end
end
