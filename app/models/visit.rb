class Visit < ActiveRecord::Base
  belongs_to :patient
  #belongs_to :physician
  has_many :physician_visits, dependent: :destroy
  has_many :physicians, through: :physician_visits
  has_many :visit_tests
  has_many :tests, through: :visit_tests

  validates_presence_of :patient_id, :physician_ids
  def self.search(search)
    joins(:patient).where('patients.firstname LIKE ? OR patients.lastname LIKE ? OR patients.middlename LIKE ? OR patients.healthnumber LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
  end
end
