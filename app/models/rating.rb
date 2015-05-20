class Rating < ActiveRecord::Base
  RATING_RANGE  = 1..5
  belongs_to :user
  belongs_to :hotel

  validates_uniqueness_of :user_id, scope: [:hotel_id]
  validates_numericality_of :rate, :in => 1..5
  validates_presence_of :user, :hotel

end
