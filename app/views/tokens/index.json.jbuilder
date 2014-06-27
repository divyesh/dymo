json.array!(@tokens) do |token|
  json.extract! token, :id, :no, :patient_id
  json.url token_url(token, format: :json)
end
