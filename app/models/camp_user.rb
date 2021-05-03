class CampUser < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :user_image

  USER_GENDER = { 
    male: "male",
    female: "female",
    other: "other"
  }
  CAMP_ACTIVITIES = ['none', 'Hiking', 'Fishing', 'Scavenger hunt']

  enum gender: USER_GENDER
end
