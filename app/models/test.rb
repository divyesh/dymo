class Test < ActiveRecord::Base
  has_many :visit_tests
  has_many :visits, through: :visit_tests
end
