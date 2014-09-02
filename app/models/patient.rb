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

  def new_time_in_token(user)
    token = Token.new({
      patient: self,
      no: Token.where("(created_at >= ? AND created_at <= ?)", DateTime.now.beginning_of_day, DateTime.now.end_of_day).size + 1
    })
    token.user = user
    token.save!

    token_history = token.token_histories.build
    token_history.punch_in_time = token.created_at
    token_history.note = "time_in"
    token_history.user = user
    token_history.save!
    token
  end

  def patient_full_name
    "#{lastname} #{firstname} "
  end

  def fullname_with_health_insurance_number
    "#{healthnumber} - #{lastname} #{firstname} #{middlename}"
  end

  def time_in_token(user)
    token = tokens.where("(created_at >= ? AND created_at <= ?) AND state = ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day, "time_in").first
    unless token
      token = self.new_time_in_token(user) 
    else
      token.user = user
    end
    token
  end

  def last_visit
    visits.order("created_at DESC").first
  end

  def last_visit_date
    visit = visits.order("created_at DESC").first
    if visit && !visit.new_record?
      visit.visitdate.blank? ? "" : "#{visit.lab_number} #{visit.visitdate.to_formatted_s(:long)}"
    else
      "First visit"
    end
  end
end
