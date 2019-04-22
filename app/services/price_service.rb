# frozen_string_literal: true

class PriceService
  class InvalidDurationError < StandardError; end

  SHORT_DURATION_PRICE = 25
  SHORT_DURATION_EXTRA = 15
  LONG_DURATION_PRICE = 35
  LONG_DURATION_EXTRA = 20

  def initialize(dog_walk)
    @dog_walk = dog_walk
  end

  def calculate
    extra_pets = @dog_walk.pets.count - 1

    case @dog_walk.duration
    when 30
      SHORT_DURATION_PRICE + (extra_pets * SHORT_DURATION_EXTRA)
    when 60
      LONG_DURATION_PRICE + (extra_pets * LONG_DURATION_EXTRA)
    else
      raise InvalidDurationError
    end
  end
end
