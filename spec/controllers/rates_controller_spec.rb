require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  let(:user) { create :user }
  let(:user_creator) { create :user }
  let!(:hotel) { create :hotel, user: user_creator }

  let(:invalid_attributes) { {hotel_id: hotel.id, rate: {'rate' => '', 'comment' => ''} } }

  describe "#create" do
    before(:each) { sign_in(user) }
    context "with valid params" do
      let(:valid_attributes) { {hotel_id: hotel.id, rate: {'rate' => '2', 'comment' => 'This is comment!'} } }

      it "creates a new Rate" do
        expect { post :create, valid_attributes }.to change(Rate, :count).from(1).to(2)
      end

      it "assigns @rate" do
        post :create, valid_attributes
        expect(assigns(:rate)).to be_a(Rate)
        expect(assigns(:rate)).to be_persisted
      end

      it "redirects to the rated hotel" do
        post :create, valid_attributes
        expect(response).to redirect_to(hotel)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved @rate" do
        post :create, invalid_attributes
        expect(assigns(:rate)).to be_a_new(Rate)
      end

      it "redirects to the hotel" do
        post :create, invalid_attributes
        expect(response).to redirect_to(hotel)
      end
    end
  end

  describe "#update" do
    before(:each) { sign_in(user_creator) }
    let(:rate) { hotel.rates.first }
    let(:update_attributes) { {hotel_id: hotel.id, rate: {'rate' => '4', 'comment' => 'This is updated comment!'} } }

    context "with valid params" do
      it "assigns @rate" do
        put :update, update_attributes.merge(id: rate.id)
        expect(assigns(:rate)).to eq(rate)
      end

      it "redirects to the hotel" do
        put :update, update_attributes.merge(id: rate.id)
        expect(response).to redirect_to(hotel)
      end
    end

    context "with invalid params" do
      it "assigns the hotel as @hotel" do
        put :update, invalid_attributes.merge(id: rate.id)
        expect(assigns(:rate)).to eq(rate)
      end

      it "redirects to the hotel" do
        put :update, invalid_attributes.merge(id: rate.id)
        expect(response).to redirect_to(hotel)
      end
    end
  end
end
