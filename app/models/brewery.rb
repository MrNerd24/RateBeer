class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  only_integer: true}
  validate :less_than_this_year, on: :create

  include RatingAverage

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }


  def less_than_this_year
    if year > Time.now.year
      errors.add(:year, "Year can't be set in the future.")
    end
  end

  def to_s
    "#{name}"
  end

end
