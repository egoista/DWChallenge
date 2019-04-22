# frozen_string_literal: true

class CreateDogWalk < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walks do |t|
      t.integer :status
      t.references :owner, foreign_key: true
      t.references :walker, foreign_key: true
      t.references :starting_position, foreign_key: { to_table: :positions }
      t.references :ending_position, foreign_key: { to_table: :positions }
      t.integer :price
      t.date :scheduled_date
      t.integer :duration
      t.time :scheduled_start_time
      t.datetime :start_time
      t.time :scheduled_end_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
