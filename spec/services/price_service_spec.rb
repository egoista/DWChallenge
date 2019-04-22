# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceService do
  describe '#calculate' do
    context 'when dogwalk has only 1 pet' do
      subject { described_class.new(dog_walk).calculate }

      context 'when dogwalk duration is 30' do
        let(:dog_walk) { FactoryBot.create(:dog_walk, duration: 30) }
        it { is_expected.to eq 25 }
      end
      context 'when dogwalk duration is 60' do
        let(:dog_walk) { FactoryBot.create(:dog_walk, duration: 60) }
        it { is_expected.to eq 35 }
      end
      context 'when dogwalk duration is invalid' do
        let(:dog_walk) { FactoryBot.build(:dog_walk, duration: 45) }
        it 'raises PriceService::InvalidDurationError' do
          expect { subject }.to raise_error(PriceService::InvalidDurationError)
        end
      end
    end
  end

  context 'when dogwalk has more pets' do
    subject { described_class.new(dog_walk).calculate }

    context 'when dogwalk duration is 30' do
      let(:dog_walk) { FactoryBot.create(:dog_walk, pets_count: 2, duration: 30) }
      it { is_expected.to eq 40 }
    end
    context 'when dogwalk duration is 60' do
      let(:dog_walk) { FactoryBot.create(:dog_walk, pets_count: 2, duration: 60) }
      it { is_expected.to eq 55 }
    end
    context 'when dogwalk duration is invalid' do
      let(:dog_walk) { FactoryBot.build(:dog_walk, pets_count: 2, duration: 45) }
      it 'raises PriceService::InvalidDurationError' do
        expect { subject }.to raise_error(PriceService::InvalidDurationError)
      end
    end
  end
end
