class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :styles, through: :beers

  validates :username, uniqueness: true, length: {minimum: 3, maximum: 30}
  validates :password, format: {with: /\A(?=.{4,})(?=.*\d)(?=.*[A-Z])/x, message: 'has to be atleast 4 characters and must include an uppercase letter and a digit.'}

  has_secure_password

  include RatingAverage

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings_of_breweries = ratings.group_by { |r| r.beer.brewery }
    averages_of_breweries = []
    ratings_of_breweries.each do |brewery, ratings|
      averages_of_breweries << {
          brewery: brewery,
          rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end
    averages_of_breweries.sort_by { |b| -b[:rating] }.first[:brewery]
  end

  def favorite_style
    return nil if ratings.empty?

    ratings_of_styles = ratings.group_by { |r| r.beer.style }
    averages_of_styles = []
    ratings_of_styles.each do |style, ratings|
      averages_of_styles << {
          style: style,
          rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end
    averages_of_styles.sort_by { |b| -b[:rating] }.first[:style]
  end
end
