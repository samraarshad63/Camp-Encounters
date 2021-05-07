class Camp < ApplicationRecord
  has_and_belongs_to_many :locations
  has_many :camp_users, dependent: :destroy 
  has_many :users, through: :camp_users

  validate :camp_dates

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

  def camp_dates
    return unless end_date < start_date
    
    errors.add :start_date, 'should be before the end date'
  end

  def invalid_camp?
    start_date < DateTime.now
  end
end
