class Hotel < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_one :address, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :address

  has_many :rates, dependent: :destroy, inverse_of: :hotel
  accepts_nested_attributes_for :rates
  # ratyrate_rateable *%w(general)

  validates :title, presence: true
  validates :rates, presence: true

  def price_decimal
    price_cents.to_d / 100 if price_cents
  end

  def price_decimal=(value)
    self.price_cents = value.to_d * 100 if value.present?
  end

  def price_humanize
    "#{price_decimal} #{price_currency}"
  end

  def on_create_rate
    rates.find_by(user: user) || rates.build
  end
end
