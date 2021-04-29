class CampUser < ApplicationRecord
  belongs_to :camp
  belongs_to :user

  USER_GENDER = { 
    male: "male",
    female: "female",
    other: "other"
  }
  CAMP_ACTIVITIES = ['none', 'Hiking', 'Fishing', 'Scavenger hunt', 'Birdwatching', 'Cataloging Rocks', 'Canoeing', 'Snorkeling', 'Diving', 'Water Balloon fight', 'Football', 'Spelunking (caving)', 'Bonfire and Music' 'Release sky lanterns', 'Tell ghost stories', 'Shoot off fireworks', 'Stargazing' ]

  enum gender: USER_GENDER
end
