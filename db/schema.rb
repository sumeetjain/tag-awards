# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170403185947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "awards", force: :cascade do |t|
    t.string   "award_name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "relevant_fields"
    t.boolean  "inactive"
    t.boolean  "ballot_set",      default: false
    t.integer  "award_type"
  end

  add_index "awards", ["ballot_set"], name: "index_awards_on_ballot_set", using: :btree

  create_table "ballot_items", force: :cascade do |t|
    t.string   "nominee"
    t.string   "role"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "award_id"
    t.integer  "play_id"
    t.boolean  "approved"
    t.integer  "weight"
    t.integer  "voting_period_id"
    t.integer  "score"
  end

  add_index "ballot_items", ["award_id"], name: "index_ballot_items_on_award_id", using: :btree
  add_index "ballot_items", ["play_id"], name: "index_ballot_items_on_play_id", using: :btree
  add_index "ballot_items", ["voting_period_id"], name: "index_ballot_items_on_voting_period_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "legacy_nominations", force: :cascade do |t|
    t.string   "nominee"
    t.string   "role"
    t.boolean  "open"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "award_id"
    t.string   "theater"
    t.string   "show"
    t.boolean  "approved"
    t.integer  "voting_period_id"
    t.integer  "potential_nomination_id"
  end

  add_index "legacy_nominations", ["award_id"], name: "index_legacy_nominations_on_award_id", using: :btree
  add_index "legacy_nominations", ["user_id"], name: "index_legacy_nominations_on_user_id", using: :btree
  add_index "legacy_nominations", ["voting_period_id"], name: "index_legacy_nominations_on_voting_period_id", using: :btree

  create_table "nominations", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "potential_nomination_id"
    t.integer  "user_id"
  end

  create_table "plays", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "theater_id"
    t.integer  "voting_period_id"
  end

  add_index "plays", ["theater_id"], name: "index_plays_on_theater_id", using: :btree
  add_index "plays", ["voting_period_id"], name: "index_plays_on_voting_period_id", using: :btree

  create_table "potential_nominations", force: :cascade do |t|
    t.integer  "award_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "play_id"
    t.string   "character"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "potential_nomination_id"
    t.integer  "job"
  end

  create_table "theaters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "weight"
    t.boolean  "admin"
    t.string   "secret_number"
    t.string   "full_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["secret_number"], name: "index_users_on_secret_number", unique: true, using: :btree

  create_table "viewings", force: :cascade do |t|
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "play_id"
  end

  add_index "viewings", ["play_id"], name: "index_viewings_on_play_id", using: :btree
  add_index "viewings", ["user_id"], name: "index_viewings_on_user_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "ballot_item_id"
  end

  add_index "votes", ["ballot_item_id"], name: "index_votes_on_ballot_item_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  create_table "voting_periods", force: :cascade do |t|
    t.integer  "year"
    t.string   "ballot_status", default: "pending"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "winners", force: :cascade do |t|
    t.integer  "ballot_item_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_foreign_key "ballot_items", "awards"
  add_foreign_key "ballot_items", "plays"
  add_foreign_key "viewings", "plays"
  add_foreign_key "viewings", "users"
  add_foreign_key "votes", "ballot_items"
  add_foreign_key "votes", "users"
end
