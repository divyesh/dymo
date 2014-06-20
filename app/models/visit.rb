class Visit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :physician
  validates_presence_of :patient_id, :physician_id
  def self.search(search)
    Patient.search(search)
  end
end
