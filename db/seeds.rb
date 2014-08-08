# run this with below command

# bundle exec rake db:seed

Visit.where("physician_id IS NOT NULL").limit(5).each do |visit|
  PhysicianVisit.create(visit_id: visit.id, physician_id: visit.physician_id)
  puts "Visit id: #{visit.id}, Patient_id: #{visit.patient.id}"
end
puts "Migrated successfully. Total #{PhysicianVisit.count}"
