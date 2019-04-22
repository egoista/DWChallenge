# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_415_210_441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'dog_walks', force: :cascade do |t|
    t.integer 'status'
    t.bigint 'owner_id'
    t.bigint 'walker_id'
    t.bigint 'starting_position_id'
    t.bigint 'ending_position_id'
    t.integer 'price'
    t.date 'scheduled_date'
    t.integer 'duration'
    t.time 'scheduled_start_time'
    t.datetime 'start_time'
    t.time 'scheduled_end_time'
    t.datetime 'end_time'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['ending_position_id'], name: 'index_dog_walks_on_ending_position_id'
    t.index ['owner_id'], name: 'index_dog_walks_on_owner_id'
    t.index ['starting_position_id'], name: 'index_dog_walks_on_starting_position_id'
    t.index ['walker_id'], name: 'index_dog_walks_on_walker_id'
  end

  create_table 'dog_walks_pets', id: false, force: :cascade do |t|
    t.bigint 'dog_walk_id', null: false
    t.bigint 'pet_id', null: false
    t.index %w[dog_walk_id pet_id], name: 'index_dog_walks_pets_on_dog_walk_id_and_pet_id'
    t.index %w[pet_id dog_walk_id], name: 'index_dog_walks_pets_on_pet_id_and_dog_walk_id'
  end

  create_table 'owners', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'pets', force: :cascade do |t|
    t.string 'name'
    t.integer 'age'
    t.integer 'size'
    t.integer 'gender'
    t.string 'breed'
    t.bigint 'owner_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['owner_id'], name: 'index_pets_on_owner_id'
  end

  create_table 'positions', force: :cascade do |t|
    t.float 'latitude'
    t.float 'longitude'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'route_points', force: :cascade do |t|
    t.bigint 'dog_walk_id'
    t.bigint 'position_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['dog_walk_id'], name: 'index_route_points_on_dog_walk_id'
    t.index ['position_id'], name: 'index_route_points_on_position_id'
  end

  create_table 'walkers', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'dog_walks', 'owners'
  add_foreign_key 'dog_walks', 'positions', column: 'ending_position_id'
  add_foreign_key 'dog_walks', 'positions', column: 'starting_position_id'
  add_foreign_key 'dog_walks', 'walkers'
  add_foreign_key 'pets', 'owners'
  add_foreign_key 'route_points', 'dog_walks'
  add_foreign_key 'route_points', 'positions'
end
