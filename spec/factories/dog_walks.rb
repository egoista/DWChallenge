# frozen_string_literal: true

FactoryBot.define do
  factory :dog_walk do
    owner factory: :owner, strategy: :build
    starting_position factory: :position, strategy: :build
    ending_position factory: :position, strategy: :build
    duration { DogWalk::VALID_DURATIONS.sample }
    status { :created }
    scheduled_date { Date.tomorrow }
    scheduled_start_time { Time.now }
    scheduled_end_time { Time.now + 45.minutes }

    trait :invalid_expired do
      scheduled_date { Date.yesterday }
    end

    trait :expired do
      after(:create) do |dog_walk, _|
        dog_walk.update(scheduled_date: Date.yesterday)
      end
    end

    transient do
      pets_count { 1 }
    end

    after(:create) do |dog_walk, evaluator|
      create_list(:pet, evaluator.pets_count, dog_walks: [dog_walk])
    end
  end
end
