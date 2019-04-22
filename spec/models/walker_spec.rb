# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Walker do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { should have_many(:dog_walks) }
  end
end
