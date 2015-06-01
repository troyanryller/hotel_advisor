class Rate < ActiveRecord::Base
  MIN_RATE = 0
  MAX_RATE = 4
  VOTES_RANGE = MIN_RATE..MAX_RATE
  belongs_to :user
  belongs_to :hotel, inverse_of: :rates

  validates :rate, presence: true, inclusion: { in: 0..4, message: 'Invalid rate!' }
  validates_existence_of *%i(user hotel), allow_nil: false, allow_new: true
  validates_uniqueness_of :hotel_id, scope: [:user_id]

  before_save :recalculate_hotel_average_rate

  # Formula from: http://habrahabr.ru/company/darudar/blog/143188/
  def self.average_rate(rating_sum, n, votes_range = VOTES_RANGE)
    z = 1.64485
    v_min = votes_range.first.to_f
    v_max = votes_range.last.to_f
    v_width = (v_max - v_min)

    phat = (rating_sum - n * v_min) / v_width / n
    rating = (phat + z * z / (2 * n) - z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n)) / ( 1 + z * z / n)
    rating * v_width + v_min
  end

  def recalculate_hotel_average_rate
    hotel_rates = (Rate.where(hotel: hotel) | [self]).map(&:rate)
    rating_sum = hotel_rates.inject(:+)
    rating_count = hotel_rates.size

    hotel.update(average_rate: Rate.average_rate(rating_sum, rating_count))
  end

  def rate
    super || 0
  end

  # Move into presenter.
  def on_stars
    (MIN_RATE..rate).to_a
  end

  def off_stars
    ((rate + 1)..MAX_RATE).to_a
  end
end
