require 'rails_helper'

RSpec.describe Hotel, type: :model do
  it { should belong_to :user }
  it { should have_one :address }
  it { should accept_nested_attributes_for :address }
  it { should have_many :rates }
  it { should accept_nested_attributes_for :rates }
  it { should validate_presence_of :title }
  it { should validate_presence_of :rates }

  let(:hotel) { create :hotel }

  describe '#price_decimal' do
    context 'when price present' do
      it { expect { hotel.price_cents = 1234 }.to change(hotel, :price_decimal).to(12.34) }
    end
    context 'when price not present' do
      it { expect { hotel.price_cents = nil }.to change(hotel, :price_decimal).to be_nil }
    end
  end

  describe '#price_decimal=' do
    context 'when value present' do
      it { expect { hotel.price_decimal = 12.34 }.to change(hotel, :price_cents).to(1234) }
    end

    context 'when value not present' do
      it { expect {hotel.price_decimal = nil}.to_not change(hotel, :price_cents) }
    end
  end

  describe '#on_create_rate' do
    context 'when rate present' do
      before { hotel.rates.create(attributes_for(:rate)) }
      it { expect(hotel.on_create_rate).to be_instance_of Rate }
    end

    context 'when rate not present' do
      before { hotel.rates.destroy_all }
      it { expect(hotel.on_create_rate).to be_instance_of Rate }
    end
  end

end
