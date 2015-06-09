FactoryGirl.define do
  factory :rate do
    comment {Faker::Lorem.sentence(3) }
    rate { rand(0..4) }
    user
    hotel
  end

end
