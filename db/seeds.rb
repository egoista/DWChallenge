# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

owner = Owner.create(name: 'Dog Owner')
owner
  .pets
  .create(
    [
      { name: 'First Pet', age: 10, size: :small, gender: :male, breed: 'ViraLata' },
      { name: 'Second Pet', age: 2, size: :medium, gender: :female, breed: 'ViraLata' },
      { name: 'Third Pet', age: 5, size: :large, gender: :male, breed: 'ViraLata' }
    ]
  )

Walker.create(name: 'Dog Walker')
