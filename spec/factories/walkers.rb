# frozen_string_literal: true

FactoryBot.define do
  factory :walker do
    name { Faker::Name.name }
  end
end
