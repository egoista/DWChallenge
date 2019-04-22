# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoutePoint do
  describe 'Associations' do
    it { should belong_to(:position) }
    it { should belong_to(:dog_walk) }
  end
end
