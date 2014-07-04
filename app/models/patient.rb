class Patient < ActiveRecord::Base
  has_many :visits
  has_many :physicians, :through => :visits
  has_many :tokens
  validates_length_of :healthnumber, :maximum => 13
  validates_length_of :version_code, :maximum => 2
  validates_presence_of :firstname, :lastname

  def self.search(search)
    if search
      where('firstname LIKE ? OR lastname LIKE ? OR middlename LIKE ? OR healthnumber LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      all
    end
  end

  def fullname_with_health_insurance_number
    "#{lastname} #{firstname} #{middlename} - #{healthnumber}"
  end
  
  def time_in_token
    tokens.where("(created_at >= ? OR created_at <= ?) AND state = ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day, "time_in").first
  end
end
