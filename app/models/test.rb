class Test < ActiveRecord::Base
  belongs_to :test_group
  has_many :visit_tests
  has_many :visits, through: :visit_tests
end
