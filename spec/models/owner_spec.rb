# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Owner do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { should have_many(:dog_walks) }
    it { should have_many(:pets) }
  end
end
