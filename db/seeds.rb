# run this with below command

# bundle exec rake db:seed

Visit.where("physician_id IS NOT NULL").each do |visit|
  PhysicianVisit.create(visit_id: visit.id, physician_id: visit.physician_id)
end
puts "Migrated successfully. Total #{PhysicianVisit.count}"
