# frozen_string_literal: true

class Owner < ApplicationRecord
  has_many :dog_walks
  has_many :pets

  validates :name, presence: true
end
