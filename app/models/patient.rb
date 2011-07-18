class Patient < ActiveRecord::Base
  has_many :visits
  has_many :physicians, :through => :visits
  validates_length_of :healthnumber, :maximum => 13
  validates_length_of :version_code, :maximum => 2
  validates_presence_of :firstname, :lastname, :middlename

  def self.search(search)
    if search
      where('firstname LIKE ? OR lastname LIKE ? OR middlename LIKE ? OR healthnumber LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

  def fullname_with_health_insurance_number
    "#{lastname} #{firstname} #{middlename} - #{healthnumber}"
  end
end
