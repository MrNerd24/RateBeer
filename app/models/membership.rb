class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  validates :user_id, presence: true
  validates :beer_club_id, presence: true

end
