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

class Address < ActiveRecord::Base
  belongs_to :hotel
end
