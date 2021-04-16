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

  def self.search(keyword)
    return all if keyword.blank?

    where('firstname LIKE ? OR lastname LIKE ? OR email LIKE ? OR id LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end
end
