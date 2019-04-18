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

ActiveRecord::Schema.define(version: 2019_04_17_054734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doses", force: :cascade do |t|
    t.bigint "meal_plan_id"
    t.integer "value"
    t.string "unit"
    t.boolean "purchased", default: false
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "meal_id"
    t.string "direction"
    t.index ["ingredient_id"], name: "index_doses_on_ingredient_id"
    t.index ["meal_id"], name: "index_doses_on_meal_id"
    t.index ["meal_plan_id"], name: "index_doses_on_meal_plan_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aisle"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "diet_type"
    t.string "exclusions"
    t.string "calories"
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "meal_plan_id"
    t.string "title"
    t.string "meal_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "directions"
    t.integer "prep_time"
    t.string "meal_type"
    t.boolean "cooked", default: false, null: false
    t.index ["meal_plan_id"], name: "index_meals_on_meal_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "avatar"
    t.boolean "admin", default: false, null: false
    t.string "photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doses", "ingredients"
  add_foreign_key "doses", "meal_plans"
  add_foreign_key "doses", "meals"
  add_foreign_key "meal_plans", "users"
  add_foreign_key "meals", "meal_plans"
end
