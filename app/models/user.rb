class User < ActiveRecord::Base
  has_many :tokens
  has_many :token_histories
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable, :recoverable, :rememberable,
         :trackable, :validatable
  attr_accessor :current_location
end
