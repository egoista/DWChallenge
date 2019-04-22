# frozen_string_literal: true

class CreateRoutePoint < ActiveRecord::Migration[5.2]
  def change
    create_table :route_points do |t|
      t.references :dog_walk, foreign_key: true
      t.references :position, foreign_key: true

      t.timestamps
    end
  end
end
