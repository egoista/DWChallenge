# frozen_string_literal: true

class CreatePosition < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
