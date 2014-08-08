# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Visit.where("physician_id IS NOT NULL").each do |visit|
  PhysicianVisit.create(visit_id: visit.id, physician_id: visit.physician_id)
end
puts "Migrated successfully. Total #{PhysicianVisit.count}"
