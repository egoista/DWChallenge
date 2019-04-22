# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Walkers::DogWalksController do
  describe 'PUT #update_position' do
    context 'with valid params' do
      let!(:dog_walk) { FactoryBot.create(:dog_walk) }
      subject do
        put :update_position, params: FactoryBot.attributes_for(:position).merge(id: dog_walk.id)
      end

      it 'returns http success' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'calls update_position of dog_walk' do
        expect_any_instance_of(DogWalk).to receive(:update_position)
        subject
      end
    end

    context 'with invalid id' do
      before do
        put :update_position, params: { id: 'invalid' }
      end

      it 'returns http error' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'without latitude and longitude params' do
      let!(:dog_walk) { FactoryBot.create(:dog_walk) }
      before do
        put :update_position, params: { id: dog_walk.id }
      end

      it 'returns http error' do
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq '{"error":"Required parameter missing: latitude"}'
      end
    end
  end
end
