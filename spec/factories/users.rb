FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.base64(4) }
  end
end
