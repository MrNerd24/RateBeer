class Beer < ApplicationRecord
  belongs_to(:brewery)
  belongs_to(:style)
  has_many :ratings, dependent: :destroy
  has_many :raters,-> {uniq}, through: :ratings, source: :user

  validates :name, presence: true
  validates :style, presence: true

  include RatingAverage

  def to_s
    "#{name}, #{brewery.name}"
  end


end
