module RatingAverage

  extend ActiveSupport::Concern

  def average_rating
    if ratings.empty?
      return -1;
    end
    ratings.average(:score)
  end

end