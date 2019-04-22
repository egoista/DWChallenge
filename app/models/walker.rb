# frozen_string_literal: true

class Walker < ApplicationRecord
  has_many :dog_walks

  validates :name, presence: true
end
