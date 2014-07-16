json.array!(@tests) do |test|
  json.extract! test, :id, :loinc, :test_group, :test_code, :test_name, :specimen_source, :group_index, :index
  json.url test_url(test, format: :json)
end
