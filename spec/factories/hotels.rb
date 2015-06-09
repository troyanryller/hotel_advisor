FactoryGirl.define do
  factory :hotel do
    title { Faker::Name.title }
    room_description { Faker::Lorem.sentence(3) }
    price_cents { Faker::Number.number(5) }
    price_currency { Money.currency_codes.map(&:second).sample }
    breakfast { [true, false].sample }
    user

    after(:build) do |hotel|
      hotel.rates.build(attributes_for(:rate).merge(user: hotel.user))
      hotel.build_address(attributes_for(:address))
    end
  end

end
