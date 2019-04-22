# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    owner factory: :owner, strategy: :build
    name { Faker::Creature::Dog.name }
    breed { Faker::Creature::Dog.breed }
    gender { Pet.genders.keys.sample }
    age { rand(10) }
    size { Pet.sizes.keys.sample }

    Pet.sizes.keys.each do |size|
      trait size.to_sym do
        size { size.to_sym }
      end
    end
  end
end
