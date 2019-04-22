# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:breed) }
    it { should validate_presence_of(:size) }
    it { should validate_presence_of(:gender) }
    it { is_expected.to define_enum_for(:size).with(%i[toy small medium large very_large]) }
    it { is_expected.to define_enum_for(:gender).with(%i[male female]) }
  end

  describe 'Associations' do
    it { should belong_to(:owner) }
    it { should have_and_belong_to_many(:dog_walks) }
  end
end
