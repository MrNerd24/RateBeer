class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true, length: {minimum: 3, maximum: 30}
  validates :password, format: {with: /\A(?=.{4,})(?=.*\d)(?=.*[A-Z])/x, message: 'has to be atleast 4 characters and must include an uppercase letter and a digit.'}

  has_secure_password

  include RatingAverage

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    styles = Beer.select(:style).distinct.to_a.map() { |beer| beer.style}
    bestStyle = nil
    bestAverage = 0
    styles.each do |style|
      scores = 0
      count = 0
      self.ratings.each do |rating|
        if rating.beer.style == style
          scores += rating.score
          count += 1
        end
      end
      if not (scores == 0 && count == 0)
        average = scores/count
        if bestAverage < average
          bestAverage = average
          bestStyle = style
        end
      end

    end
    return bestStyle
  end

  def favorite_brewery
    brewerys = Brewery.all
    bestbrewery = nil
    bestAverage = 0
    brewerys.each do |brewery|
      scores = 0
      count = 0
      self.ratings.each do |rating|
        if rating.beer.brewery == brewery
          scores += rating.score
          count += 1
        end
      end
      if not (scores == 0 && count == 0)
        average = scores/count
        if bestAverage < average
          bestAverage = average
          bestbrewery = brewery
        end
      end

    end
    return bestbrewery
  end
end
