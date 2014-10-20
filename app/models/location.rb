class Location < ActiveRecord::Base
  has_many :tokens
  has_many :visits
end
