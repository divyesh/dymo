json.extract! @token, :id, :no, :state
json.add_visit_url new_visit_url(patient_id: @token.patient)
json.patient @token.patient
