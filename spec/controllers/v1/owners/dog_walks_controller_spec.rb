# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Owners::DogWalksController do
  describe 'GET #index' do
    context 'when have zero dog_walks' do
      before do
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains an empty data response' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(%w[data
                                                     pagination])
        expect(json_response['data'].empty?)
      end
    end

    context 'when have many dog_walks' do
      before do
        FactoryBot.create_list(:dog_walk, 15)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains an empty data response' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(%w[data pagination])
        expect(json_response['data'].count).to eq 10
        expect(json_response['pagination'])
          .to eq('current_page' => 1, 'next_page' => 2, 'prev_page' => nil, 'total_count' => 15, 'total_pages' => 2)

        json_response['data'].each do |json_data|
          expect(json_data.keys).to match_array(dog_walk_json_keys)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        FactoryBot.create(:owner)
        post :create, params: { dog_walk: dog_walk_valid_params }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      before do
        post :create, params: { dog_walk: dog_walk_valid_params.except(:scheduled_date) }
      end

      it 'returns http error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    context 'with valid id' do
      let!(:dog_walk) { FactoryBot.create(:dog_walk) }
      before do
        get :show, params: { id: dog_walk.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the dog_walk json' do
        expect(response.body).to eq DogWalkSerializer.new(dog_walk).to_json
      end
    end

    context 'with invalid id' do
      before do
        get :show, params: { id: 'invalid' }
      end

      it 'returns http error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT #start' do
    context 'with valid id' do
      let!(:dog_walk) { FactoryBot.create(:dog_walk) }
      before do
        put :start, params: { id: dog_walk.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'sets the dog_walk start_time and status started' do
        dog_walk.reload
        expect(dog_walk.start_time.nil?).to be_falsey
        expect(dog_walk.status).to eq 'started'
      end
    end

    context 'with invalid id' do
      before do
        get :show, params: { id: 'invalid' }
      end

      it 'returns http error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT #finish' do
    context 'with valid id' do
      let!(:dog_walk) { FactoryBot.create(:dog_walk) }
      before do
        put :finish, params: { id: dog_walk.id }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'sets the dog_walk end_time and status done' do
        dog_walk.reload
        expect(dog_walk.end_time.nil?).to be_falsey
        expect(dog_walk.status).to eq 'done'
      end
    end

    context 'with invalid id' do
      before do
        get :show, params: { id: 'invalid' }
      end

      it 'returns http error' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  def dog_walk_valid_params
    FactoryBot
      .attributes_for(:dog_walk)
      .merge(
        starting_position_attributes: FactoryBot.attributes_for(:position),
        ending_position_attributes: FactoryBot.attributes_for(:position)
      )
  end

  def dog_walk_json_keys
    %w[
      created_at
      duration
      ending_position
      id
      pets
      price
      scheduled_date
      scheduled_end_time
      scheduled_start_time
      starting_position
      status
      walk_time
      walker
    ]
  end
end
