class Hotel < ActiveRecord::Base
  belongs_to :user
  has_one :address, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :address
  ratyrate_rateable *%w(general)

  validates_associated :user
  validates_presence_of :title

  def price_decimal
    price_cents.to_d / 100 if price_cents
  end

  def price_decimal=(value)
    self.price_cents = value.to_d * 100 if value.present?
  end

  def price_humanize
    "#{price_decimal} #{price_currency}"
  end
end
