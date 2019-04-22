# frozen_string_literal: true

class CreateJoinTableDogWalkPet < ActiveRecord::Migration[5.2]
  def change
    create_join_table :dog_walks, :pets do |t|
      t.index %i[dog_walk_id pet_id]
      t.index %i[pet_id dog_walk_id]
    end
  end
end
