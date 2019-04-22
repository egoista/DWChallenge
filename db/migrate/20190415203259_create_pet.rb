# frozen_string_literal: true

class CreatePet < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.integer :size
      t.integer :gender
      t.string :breed
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
