class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, format: {with: /\A(?=.{4,})(?=.*\d)(?=.*[A-Z])/x, message: 'has to be atleast 4 characters and must include an uppercase letter and a digit.'}

  has_secure_password

  include RatingAverage
end
