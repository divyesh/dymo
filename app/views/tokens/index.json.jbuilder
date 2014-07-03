json.array!(@tokens) do |token|
  json.extract! token, :id, :no, :state
  json.patient token.patient, :id, :healthnumber
  json.url token_url(token, format: :json)
end
