class Physician < ActiveRecord::Base
  has_many :visits
  has_many :patients, :through => :visits
  validates_presence_of :firstname, :lastname

  def self.search(search)
    if search
      where('firstname LIKE ? OR lastname LIKE ? OR middlename LIKE ? OR physician_number LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")

    else
      all
    end
  end

  def fullname_with_physician_number
    "#{physician_number} #{firstname} #{lastname}"
  end
  
  def tests(from_date, to_date, str)
    if str.blank?
      @tests = self.visits.joins(visit_tests: :test).where("(visit_tests.created_at >= ? AND visit_tests.created_at <= ?)", from_date, to_date).group("tests.test_code").count
    else
      @tests = self.visits.joins(visit_tests: :test).where("(visit_tests.created_at >= ? AND visit_tests.created_at <= ?) AND tests.test_code ~ any(array[?])", from_date, to_date, str.split(/\s*,\s*/)).group("tests.test_code").count
    end
  end
end
