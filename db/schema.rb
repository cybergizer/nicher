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

ActiveRecord::Schema.define(version: 2018_08_30_094805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.bigint "user_id"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "free_item_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "potential_owner_id"
    t.integer "actual_owner_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_free_item_requests_on_deleted_at"
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "item_histories", force: :cascade do |t|
    t.bigint "item_id"
    t.integer "rent_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_histories_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "niche_id"
    t.bigint "rent_item_id"
    t.boolean "free", default: false
    t.datetime "deleted_at"
    t.bigint "free_item_request_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["deleted_at"], name: "index_items_on_deleted_at"
    t.index ["free_item_request_id"], name: "index_items_on_free_item_request_id"
    t.index ["niche_id"], name: "index_items_on_niche_id"
    t.index ["rent_item_id"], name: "index_items_on_rent_item_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "niches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "ancestry"
    t.string "url"
    t.index ["ancestry"], name: "index_niches_on_ancestry"
    t.index ["user_id"], name: "index_niches_on_user_id"
  end

  create_table "rent_items", force: :cascade do |t|
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "tenant_id"
    t.string "tenant_type"
    t.bigint "niche_id"
    t.bigint "category_id"
    t.datetime "deleted_at"
    t.index ["category_id"], name: "index_rent_items_on_category_id"
    t.index ["deleted_at"], name: "index_rent_items_on_deleted_at"
    t.index ["niche_id"], name: "index_rent_items_on_niche_id"
  end

  create_table "shared_items", force: :cascade do |t|
    t.bigint "item_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiration"
    t.index ["item_id"], name: "index_shared_items_on_item_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "last_name"
    t.string "city"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "sex"
    t.string "phone"
    t.date "birthday"
    t.string "first_name"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "item_histories", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "free_item_requests"
  add_foreign_key "items", "niches"
  add_foreign_key "items", "rent_items"
  add_foreign_key "items", "users"
  add_foreign_key "niches", "users"
  add_foreign_key "rent_items", "categories"
  add_foreign_key "rent_items", "niches"
  add_foreign_key "shared_items", "items"
end
