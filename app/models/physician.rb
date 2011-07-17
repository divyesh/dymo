class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, :through => :appointments

  def self.search(search)
    if search
      where('firstname LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
