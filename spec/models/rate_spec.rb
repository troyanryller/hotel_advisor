require 'rails_helper'

RSpec.describe Rate, type: :model do
  let!(:some_rate) { create :rate }
  it { should belong_to :user }
  it { should belong_to :hotel }
  it { should validate_uniqueness_of(:hotel_id).scoped_to(:user_id) }

  context '#self.average_rate' do
    it { expect(Rate.average_rate(10, 4)).to be_instance_of Float }
  end

  describe '#recalculate_hotel_average_rate' do
    let(:rate) { build :rate }
    let(:hotel) { rate.hotel }
    it { expect { rate.recalculate_hotel_average_rate }.to change(hotel, :average_rate) }
  end

end
