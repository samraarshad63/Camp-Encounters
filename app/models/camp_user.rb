class CampUser < ApplicationRecord
  belongs_to :camp
  belongs_to :user
end
