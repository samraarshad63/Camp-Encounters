class CampUser < ApplicationRecord
  belongs_to :camp
  belongs_to :user
  has_one_attached :user_image

  MALE = 'male'
  FEMALE = 'female'
  OTHER = 'other'
  USER_GENDER = { 
    male: MALE,
    female: FEMALE,
    other: OTHER
  }
  CAMP_ACTIVITIES = ['none', 'Hiking', 'Fishing', 'Scavenger hunt']

  enum gender: USER_GENDER

  def update_progress
    update(progress: progress + 10)
  end
end
