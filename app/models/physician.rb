class Physician < ActiveRecord::Base
  has_many :visits
  has_many :patients, :through => :visits
  validates_presence_of :firstname, :lastname, :middlename

  def self.search(search)
    if search
      where('firstname LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def fullname_with_physician_number
    "#{lastname} #{firstname} #{middlename} - #{physician_number}"
  end
end
