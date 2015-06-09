require 'rails_helper'

RSpec.describe HotelsController, type: :controller do
  let!(:hotel) { create :hotel }

  describe "#index" do
    it "assigns @hotels and renders index template" do
      get :index
      expect(assigns(:hotels)).to eq([hotel])
      expect(response).to render_template('index')
    end
  end

  describe "#top5" do
    it "assigns @hotels and renders top5 template" do
      get :top5
      expect(assigns(:hotels)).to eq([hotel])
      expect(response).to render_template('top5')
    end
  end

  describe "#show" do
    it "assigns @hotel and renders show template" do
      get :show, {id: hotel.id}
      expect(assigns(:hotel)).to eq(hotel)
      expect(response).to render_template('show')
    end
  end

  let(:user) { create :user }
  before(:each) { sign_in(user) }

  describe "#new" do
    it "assigns a new hotel as @hotel" do
      get :new, {user_id: user.id}
      expect(assigns(:hotel)).to be_a_new(Hotel)
    end
  end

  describe "#edit" do
    context 'user have permissions' do
      let(:hotel) { create :hotel, user: user }
      it "assigns @hotel and renders edit template" do
        get :edit, {id: hotel.id, user_id: user.id}
        expect(assigns(:hotel)).to eq(hotel)
        expect(response).to render_template('edit')
      end
    end
    context 'user have no permissions' do
      it "assigns @hotel and renders edit template" do
        get :edit, {id: hotel.id, user_id: user.id}
        expect(assigns(:hotel)).to eq(hotel)
        expect(response).to redirect_to(hotels_url)
      end
    end
  end

  let(:valid_attributes) do
    {
      hotel:
        {
          "title" => 'Test title',
          "room_description" => Faker::Lorem.sentence(3),
          "price_decimal" => Faker::Number.number(6),
          "price_currency" => "USD",
          "breakfast" => "1",
          "address_attributes" =>
            {
              "address" => Faker::Address.street_address,
              "address_ii" => Faker::Address.secondary_address,
              "city" => Faker::Address.city,
              "state" => Faker::Address.state,
              "country_alpha2" => Faker::Address.country_code
            },
          "rates_attributes" => {"0" => {"user_id" => user.id, "rate" => rand(0..4)}}
        },
      user_id: user.id
    }
  end

  let(:invalid_attributes) do
    {
      hotel: { 'title' => '', 'breakfast' => 'q' },
      user_id: user.id
    }
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new Hotel" do
        expect {
          post :create, valid_attributes
        }.to change(Hotel, :count).by(1)
      end

      it "assigns a newly created hotel as @hotel" do
        post :create, valid_attributes
        expect(assigns(:hotel)).to be_a(Hotel)
        expect(assigns(:hotel)).to be_persisted
      end

      it "redirects to the created hotel" do
        post :create, valid_attributes
        expect(response).to redirect_to(Hotel.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved hotel as @hotel" do
        post :create, invalid_attributes
        expect(assigns(:hotel)).to be_a_new(Hotel)
      end

      it "re-renders the 'new' template" do
        post :create, invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe "#update" do
    let(:hotel) { create :hotel, user: user }
    let(:hotel_attributes) { valid_attributes[:hotel].except('rates_attributes') }
    let(:update_attributes) { valid_attributes.merge(hotel: hotel_attributes) }
    context "with valid params" do
      it "assigns the requested hotel as @hotel" do
        put :update, update_attributes.merge(id: hotel.id)
        expect(assigns(:hotel)).to eq(hotel)
      end

      it "redirects to the hotel" do
        put :update, update_attributes.merge(id: hotel.id)
        expect(response).to redirect_to(hotel)
      end
    end

    context "with invalid params" do
      it "assigns the hotel as @hotel" do
        put :update, invalid_attributes.merge(id: hotel.id)
        expect(assigns(:hotel)).to eq(hotel)
      end

      it "re-renders the 'edit' template" do
        put :update, invalid_attributes.merge(id: hotel.id)
        expect(response).to render_template('edit')
      end
    end
  end

  describe "#destroy" do
    let(:hotel) { create :hotel, user: user }
    it "destroys the requested hotel" do
      expect { delete :destroy, {id: hotel.id, user_id: user.id} }.to change(Hotel, :count).by(-1)
    end

    it "redirects to the hotels list" do
      delete :destroy, {id: hotel.id, user_id: user.id}
      expect(response).to redirect_to(hotels_url)
    end
  end

end
