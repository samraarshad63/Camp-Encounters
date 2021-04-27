class Camp < ApplicationRecord
  has_and_belongs_to_many :locations
  has_many :camp_users
  has_many :users, through: :camp_users

  CAMPS_PER_PAGE = 5
  CAMP_STATUS = { 
    active: "active",
    inactive: "inactive"
  }

  enum status: CAMP_STATUS

  def self.search(keyword)
    return all if keyword.blank?

    where('camp_name LIKE :value', {value: keyword})
  end
end
