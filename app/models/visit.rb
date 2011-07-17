class Visit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :physician
  validates_presence_of :patient_id, :physician_id, :message => "Please select value"
  def self.search(search)
    joins(:patient) & Patient.search(search)
  end
end
