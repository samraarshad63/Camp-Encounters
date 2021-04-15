class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :validatable
  
  MIN_PASSWORD_LENGTH = 7
  PER_PAGE = 3
  USER_ROLES = { 
  	user: "user"
  }.freeze
  
  enum user_role: USER_ROLES

  validates_acceptance_of :terms, allow_nil: false, accept: true

  def self.search(search)
    return all if search.blank?

    where('users.firstname LIKE ? OR users.lastname LIKE ? OR users.email LIKE ? OR users.id LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
