# frozen_string_literal: true

FactoryBot.define do
  factory :position do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
