class Token < ActiveRecord::Base
  belongs_to :patient
  has_many :token_histories
end
