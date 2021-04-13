class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :validatable
  
  MIN_PASSWORD_LENGTH = 7
  USER_ROLES = { 
  	user: "user"
  }.freeze
  enum user_role: USER_ROLES

  validates_acceptance_of :terms, allow_nil: false, accept: true

end
