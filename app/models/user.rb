class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :confirmable , :registerable, :recoverable, :rememberable, :validatable
  
  MIN_PASSWORD_LENGTH = 7

  validates_acceptance_of :terms, allow_nil: false, accept: true
end
