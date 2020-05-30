# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_28_231711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.string "id_str"
    t.string "text"
    t.boolean "truncated"
    t.text "entities"
    t.string "source"
    t.bigint "in_reply_to_status_id"
    t.string "in_reply_to_status_id_str"
    t.bigint "in_reply_to_user_id"
    t.string "in_reply_to_user_id_str"
    t.string "in_reply_to_screen_name"
    t.text "user"
    t.text "geo"
    t.text "coordinates"
    t.text "place"
    t.text "contributors"
    t.boolean "is_quote_status"
    t.integer "retweet_count"
    t.integer "favorite_count"
    t.boolean "favorited"
    t.boolean "retweeted"
    t.string "lang"
    t.boolean "possibly_sensitive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
