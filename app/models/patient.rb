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

  def new_time_in_token
    token = Token.new({
      patient: self,
      no: Token.where("(created_at >= ? AND created_at <= ?)", DateTime.now.beginning_of_day, DateTime.now.end_of_day).size + 1
    })

    token.save!

    token_history = token.token_histories.build
    token_history.punch_in_time = token.created_at
    token_history.note = "time_in"
    token_history.save!
    token
  end


  def fullname_with_health_insurance_number
    "#{lastname} #{firstname} #{middlename} - #{healthnumber}"
  end

  def time_in_token
    tokens.where("(created_at >= ? AND created_at <= ?) AND state = ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day, "time_in").first
  end

  def last_visit_date
    visits.size > 0 ? visits.order("created_at DESC").first.visitdate.to_formatted_s(:long) : ""
  end
end
