namespace :dymo do  

  desc "merge tests from location to location"
  task merge_test: :environment do
    puts "Please enter location_id whose tests you want to migrate to current db: "
    location_id = STDIN.gets.strip
    
    Test.where("location_id = ?", location_id).each do |test|
      test_group = TestGroup.where("old_id = ? AND location_id = ?", test.test_group_id, location_id).first
      test_groups = TestGroup.where("lower(name) = ?", test_group.name.downcase)
      
      if test_groups.count > 1
        test_group = TestGroup.where("lower(name) = ? AND location_id = ?", test_group.name.downcase, 1).first
        TestGroup.where("lower(name) = ? AND location_id != ?", test_group.name.downcase, 1).delete_all
      end
      test.test_group_id = test_group.id
      test.save!
    end
  end
  
  desc "merge visits from location to location"
  task merge_visits: :environment do
    puts "Please enter location_id whose visits you want to migrate to current db: "
    location_id = STDIN.gets.strip
    
    Visit.where("location_id = ?", location_id).each do |visit|
      visit_patient = Patient.where("old_id = ?", visit.patient_id).first
      patient = visit_patient

      # update patient id for visit and remove duplicate patient
      if visit_patient
        patients = Patient.where("healthnumber = ?", visit_patient.healthnumber)
        
        if patients.count > 1
          patient = Patient.where("healthnumber = ? AND location_id = ?", visit_patient.healthnumber, 1).first
          Patient.where("healthnumber = ? AND location_id != ?", visit_patient.healthnumber, 1).delete_all
        end
        visit.patient_id = patient.id
        visit.save!
      end

      # update visit_test id for visit and remove duplicate patient
      visit_test = VisitTest.where("visit_id = ?", visit.old_id).first
      visit_test.visit_id = visit.id

      test = Test.where("old_id = ?", visit_test.test_id)
      tests = Test.where("test_code = ?", test.test_code)
      
      if tests.count > 1
        test = Test.where("test_code = ? AND location_id = ?", test.test_code, 1).first
        Test.where("test_code = ? AND location_id != ?", test.test_code, 1).delete_all
      end

      visit_test.test_id = test.id
      visit_test.save!

      # update visit_test id for visit and remove duplicate patient
      physician_visit = PhysicianVisit.where("visit_id = ?", visit.old_id).first
      physician_visit.visit_id = visit.id

      physician = Physician.where("old_id = ?", physician_visit.physician_id)
      physicians = Physician.where("physician_number = ?", physician.physician_number)

      if physicians.count > 1
        physician = Physician.where("physician_number = ? AND location_id = ?", physician.physician_number, 1).first
        Physician.where("physician_number = ? AND location_id != ?", physician.physician_number, 1).delete_all
      end
      
      physician_visit.physician_id = physician.id
      physician_visit.save!
    end
    puts "Done !"
  end

  desc "get number of duplicate patients"
  task duplicate_patients: :environment do
    patients = Patient.select("id, count(id) as quantity").group(:healthnumber).having("quantity > 1")
    puts "Duplicae patients: #{patients.to_a.size}"
  end

  desc "get number of duplicate physicians"
  task duplicate_physicians: :environment do
    physicians = Physician.select("id, count(id) as quantity").group(:physician_number).having("quantity > 1")
    puts "Duplicae physicians: #{physicians.to_a.size}"
  end

  desc "get number of duplicate test groups"
  task duplicate_test_groups: :environment do
    test_groups = TestGroup.select("id, count(id) as quantity").group(:name).having("quantity > 1")
    puts "Duplicae test_groups: #{test_groups.to_a.size}"
  end

  desc "get number of duplicate tests"
  task duplicate_tests: :environment do
    tests = Test.select("id, count(id) as quantity").group(:test_code).having("quantity > 1")
    puts "Duplicae tests: #{tests.to_a.size}"
  end

  desc "sets tests position value from index column."
  task set_tests_position: :environment do
    puts "setting tests positions..."
    Test.all.each do |test|
      test.position = test.index.blank? ? 0 : test.index.to_i
      test.save!
    end
    puts "Test positions were set successfully from index column."
  end

  desc "set test groups from tests table."
  task set_test_groups: :environment do
    puts "setting tests groups..."
    test_groups = Test.select("test_group_old").group("test_group_old")

    test_groups.each do |test_group|
      TestGroup.create!({ name: test_group.test_group_old })
    end

    puts "Test Groups were set successfully from tests table. Positions are not set, so set them manually via web application."
  end

  desc "sets test_group_id for tests"
  task set_test_group_id: :environment do
    puts "setting test_group_id..."
    Test.all.each do |test|
      test.test_group_id = TestGroup.where("name = ?", test.test_group_old).first.id
      test.save!
    end
    puts "test_group_id were set successfully."
  end

  desc "migrate tests and test_groups"
  task set_tests_and_test_groups: :environment do
    Rake::Task["dymo:set_tests_position"].invoke
    Rake::Task["dymo:set_test_groups"].invoke
    Rake::Task["dymo:set_test_group_id"].invoke
    puts "Done!"
  end
end
