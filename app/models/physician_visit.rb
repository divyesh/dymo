class PhysicianVisit < ActiveRecord::Base
  belongs_to :visit
  belongs_to :physician
end
