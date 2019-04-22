# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Owners::PetsController do
  describe 'GET #index' do
    before do
      owner = FactoryBot.create(:owner)
      FactoryBot.create_list(:pet, 5, owner: owner)
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains an empty data response' do
      json_response = JSON.parse(response.body)
      json_response.each do |pet_hash|
        expect(pet_hash.keys).to match_array(pet_json_keys)
      end
    end
  end

  private

  def pet_json_keys
    %w[
      age 
      breed 
      gender 
      id 
      name 
      size
    ]
  end
end
