class Camp < ApplicationRecord
  has_and_belongs_to_many :locations
  has_many :camp_users, dependent: :destroy 
  has_many :users, through: :camp_users

  CAMPS_PER_PAGE = 5
  CAMP_STATUS = { 
    active: "active",
    inactive: "inactive"
  }

  enum status: CAMP_STATUS

  scope :active, -> { where(status: "active") }

  def self.search(keyword)
    return all if keyword.blank?

    keyword = keyword.downcase
    where('lower(camp_name) like :value', {value: keyword})
  end
end
