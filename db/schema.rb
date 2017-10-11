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

ActiveRecord::Schema.define(version: 20171010203248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "awards", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "award_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_awards_on_name", unique: true
  end

  create_table "nominatables", force: :cascade do |t|
    t.bigint "award_id", null: false
    t.integer "nominee_id", null: false
    t.string "nominee_type", null: false
    t.string "display_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["award_id"], name: "index_nominatables_on_award_id"
    t.index ["nominee_type", "nominee_id"], name: "index_nominatables_on_nominee_type_and_nominee_id"
  end

  create_table "plays", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "voting_period_id", null: false
    t.bigint "theater_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theater_id"], name: "index_plays_on_theater_id"
    t.index ["title", "voting_period_id", "theater_id"], name: "index_plays_on_title_and_voting_period_id_and_theater_id", unique: true
    t.index ["voting_period_id"], name: "index_plays_on_voting_period_id"
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "play_id", null: false
    t.integer "job_type", null: false
    t.string "character"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "play_id", "character", "job_type"], name: "index_roles_on_artist_id_and_play_id_and_character_and_job_type", unique: true
    t.index ["artist_id"], name: "index_roles_on_artist_id"
    t.index ["play_id"], name: "index_roles_on_play_id"
  end

  create_table "theaters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_theaters_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "full_name", null: false
    t.boolean "membership_active", default: true, null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "viewings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "play_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_id"], name: "index_viewings_on_play_id"
    t.index ["user_id", "play_id"], name: "index_viewings_on_user_id_and_play_id", unique: true
    t.index ["user_id"], name: "index_viewings_on_user_id"
  end

  create_table "voting_periods", force: :cascade do |t|
    t.integer "year", null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "nominations_active", default: false, null: false
    t.boolean "voting_active", default: false, null: false
    t.index ["year"], name: "index_voting_periods_on_year", unique: true
  end

  add_foreign_key "nominatables", "awards"
  add_foreign_key "plays", "theaters"
  add_foreign_key "plays", "voting_periods"
  add_foreign_key "roles", "artists"
  add_foreign_key "roles", "plays"
  add_foreign_key "viewings", "plays"
  add_foreign_key "viewings", "users"
end
