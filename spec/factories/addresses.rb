# == Schema Information
#
# Table name: addresses
#
#  id             :integer          not null, primary key
#  hotel_id       :integer
#  address        :string
#  address_ii     :string
#  city           :string
#  state          :string
#  country_alpha2 :string(2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :address do
    address { Faker::Address.street_address }
    address_ii { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country_alpha2 { Faker::Address.country_code }
    hotel
  end

end
