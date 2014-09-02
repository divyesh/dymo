class Test < ActiveRecord::Base
  belongs_to :test_group
  has_many :visit_tests
  has_many :visits, through: :visit_tests
  
  def visible?(test_ids)
    visible_in_list? || test_ids.include?(self.id)
  end
end
