json.array!(@token_histories) do |token_history|
  json.extract! token_history, :id, :token_id, :punch_in_time, :note
  json.url token_history_url(token_history, format: :json)
end
