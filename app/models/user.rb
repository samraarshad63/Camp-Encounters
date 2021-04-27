class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :validatable

  has_one :camp_user
  has_one :camp, through: :camp_user
  
  MIN_PASSWORD_LENGTH = 7
  PER_PAGE = 3
  USER_ROLES = { 
    user: "user"
  }
  CSV_HEADERS = ['Firstname', 'Lastname', 'Email', 'Contact', 'Country']
  
  enum user_role: USER_ROLES

  scope :active, -> { where(status: "active") }

  validates_acceptance_of :terms, allow_nil: false, accept: true

  def self.search(keyword)
    return all if keyword.blank?

    where('firstname LIKE :value OR lastname LIKE :value OR email LIKE :value OR id LIKE :value', {value: keyword})
  end
end
