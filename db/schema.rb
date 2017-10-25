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

ActiveRecord::Schema.define(version: 20171025024625) do

  create_table "book_tours", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tour_id"
    t.bigint "user_id"
    t.integer "number_person"
    t.text "note"
    t.integer "status"
    t.string "transaction_id"
    t.datetime "purchased_date"
    t.float "price", limit: 24
    t.float "total_price", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_book_tours_on_tour_id"
    t.index ["user_id"], name: "index_book_tours_on_user_id"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id_parent"
    t.bigint "travel_id"
    t.bigint "user_id"
    t.bigint "category_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_comments_on_category_id"
    t.index ["travel_id"], name: "index_comments_on_travel_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "travel_id"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_id"], name: "index_images_on_travel_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "comment_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id", "user_id"], name: "index_likes_on_comment_id_and_user_id", unique: true
    t.index ["comment_id"], name: "index_likes_on_comment_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "city"
    t.text "description"
    t.boolean "flg_del", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "date_start"
    t.datetime "date_end"
    t.text "name"
    t.text "description"
    t.float "discus_percent", limit: 24
    t.integer "flg_del"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "travel_id"
    t.bigint "user_id"
    t.float "star_number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_id", "user_id"], name: "index_ratings_on_travel_id_and_user_id", unique: true
    t.index ["travel_id"], name: "index_ratings_on_travel_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "tours", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "travel_id"
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_id"], name: "index_tours_on_travel_id"
  end

  create_table "travels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.boolean "flg_promotion", default: false
    t.text "schedule"
    t.text "description"
    t.string "tour_duration"
    t.text "note"
    t.integer "id_place_from"
    t.integer "id_place_to"
    t.float "price", limit: 24
    t.bigint "promotion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promotion_id"], name: "index_travels_on_promotion_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role", default: 1, null: false
    t.string "address"
    t.string "telphone"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "book_tours", "tours"
  add_foreign_key "book_tours", "users"
  add_foreign_key "comments", "categories"
  add_foreign_key "comments", "travels"
  add_foreign_key "comments", "users"
  add_foreign_key "images", "travels"
  add_foreign_key "likes", "comments"
  add_foreign_key "likes", "users"
  add_foreign_key "ratings", "travels"
  add_foreign_key "ratings", "users"
  add_foreign_key "tours", "travels"
  add_foreign_key "travels", "promotions"
end
