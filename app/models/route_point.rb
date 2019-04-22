# frozen_string_literal: true

class RoutePoint < ApplicationRecord
  belongs_to :position
  belongs_to :dog_walk
end
