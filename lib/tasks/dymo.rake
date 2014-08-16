namespace :dymo do
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
