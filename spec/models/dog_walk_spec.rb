# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DogWalk do
  describe 'Validations' do
    it { should validate_presence_of(:duration) }
    it { should validate_inclusion_of(:duration).in_array(DogWalk::VALID_DURATIONS) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:scheduled_date) }
    it { should validate_presence_of(:scheduled_start_time) }
    it { should validate_presence_of(:scheduled_end_time) }
    it 'validates the scheduled_date_time is future' do
      dog_walk = FactoryBot.build(:dog_walk, :invalid_expired)

      expect(dog_walk.valid?).to be_falsey
      expect(dog_walk.errors.to_a).to eq(["Scheduled date can't be in the past"])
    end
  end

  describe 'Associations' do
    it { should belong_to(:owner) }
    it { should belong_to(:walker) }
    it { should belong_to(:starting_position) }
    it { should belong_to(:ending_position) }
    it { should have_many(:route_points) }
    it { should have_and_belong_to_many(:pets) }
  end

  describe 'Scopes' do
    describe '.future_walks' do
      let!(:future_walk) { FactoryBot.create(:dog_walk) }
      let!(:past_walk) { FactoryBot.create(:dog_walk, :expired) }

      it 'returns future walks' do
        expect(DogWalk.future_walks.to_a).to eq [future_walk]
      end
    end
  end

  describe '#start_walk' do
    let(:dog_walk) { FactoryBot.create(:dog_walk) }

    it 'update DogWalk start_time' do
      Timecop.freeze do
        dog_walk.start_walk
        expect(dog_walk.start_time).to eq(Time.now)
      end
    end
  end
  describe '#finish_walk' do
    let(:dog_walk) { FactoryBot.create(:dog_walk) }

    it 'update DogWalk end_time' do
      Timecop.freeze do
        dog_walk.finish_walk
        expect(dog_walk.end_time).to eq(Time.now)
      end
    end
  end

  describe '#update_position' do
    let(:dog_walk) { FactoryBot.create(:dog_walk) }

    it 'creates a new route_point' do
      latitude = Faker::Address.latitude
      longitude = Faker::Address.longitude
      dog_walk.update_position(latitude, longitude)
      position = dog_walk.route_points.first.position

      expect(dog_walk.route_points.count).to eq 1
      expect(position.latitude.round(4)).to eq latitude.round(4)
      expect(position.longitude.round(4)).to eq longitude.round(4)
    end
  end
end
