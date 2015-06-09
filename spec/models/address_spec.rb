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

require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should belong_to :hotel }
end
