# frozen_string_literal: true

class Pet < ApplicationRecord
  enum gender: %i[male female]
  enum size: %i[toy small medium large very_large]

  belongs_to :owner
  has_and_belongs_to_many :dog_walks

  validates :age, :breed, :name, :gender, :size, presence: true
end
