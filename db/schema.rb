# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_12_020921) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_configs", force: :cascade do |t|
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_phone"
    t.string "office_hours_weekday"
    t.string "office_hours_saturday"
    t.string "hero_title"
    t.string "hero_subtitle"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "property_id"
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.string "room_type"
    t.string "meal_plan"
    t.integer "rooms"
    t.date "check_in"
    t.date "check_out"
    t.integer "adults"
    t.integer "children"
    t.string "additional_service_request"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["property_id"], name: "index_bookings_on_property_id"
    t.index ["token"], name: "index_bookings_on_token", unique: true
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "rating", precision: 2, scale: 1
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "popular_filters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "popular_properties", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.integer "sort_order", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_popular_properties_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "tagline"
    t.text "short_description"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "normal_price", precision: 10, scale: 2
    t.decimal "discounted_price", precision: 10, scale: 2
    t.integer "discount_percent"
    t.decimal "current_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "discount_text"
    t.string "offer_text"
    t.index ["slug"], name: "index_properties_on_slug", unique: true
  end

  create_table "property_activities", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_property_activities_on_activity_id"
    t.index ["property_id"], name: "index_property_activities_on_property_id"
  end

  create_table "property_facilities", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_property_facilities_on_facility_id"
    t.index ["property_id"], name: "index_property_facilities_on_property_id"
  end

  create_table "property_images", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.integer "sort_order", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_images_on_property_id"
  end

  create_table "property_popular_filters", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.bigint "popular_filter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["popular_filter_id"], name: "index_property_popular_filters_on_popular_filter_id"
    t.index ["property_id"], name: "index_property_popular_filters_on_property_id"
  end

  create_table "room_categories", force: :cascade do |t|
    t.string "name"
    t.bigint "property_id", null: false
    t.decimal "normal_price", precision: 10, scale: 2
    t.decimal "discounted_price", precision: 10, scale: 2
    t.integer "discount_percent"
    t.decimal "current_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "short_description"
    t.text "full_description"
    t.string "size_sqm"
    t.string "size_sqft"
    t.integer "max_adults", default: 2
    t.integer "max_children", default: 0
    t.integer "num_bedrooms", default: 1
    t.integer "num_bathrooms", default: 1
    t.string "bed_configuration"
    t.boolean "has_pool", default: false
    t.boolean "has_beach_access", default: false
    t.boolean "has_ocean_view", default: false
    t.text "comfort_amenities"
    t.text "convenience_features"
    t.index ["property_id"], name: "index_room_categories_on_property_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: true
    t.datetime "publish_date"
  end

  create_table "story_tags", force: :cascade do |t|
    t.bigint "story_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_story_tags_on_story_id"
    t.index ["tag_id"], name: "index_story_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "properties"
  add_foreign_key "popular_properties", "properties"
  add_foreign_key "property_activities", "activities"
  add_foreign_key "property_activities", "properties"
  add_foreign_key "property_facilities", "facilities"
  add_foreign_key "property_facilities", "properties"
  add_foreign_key "property_images", "properties"
  add_foreign_key "property_popular_filters", "popular_filters"
  add_foreign_key "property_popular_filters", "properties"
  add_foreign_key "room_categories", "properties"
  add_foreign_key "story_tags", "stories"
  add_foreign_key "story_tags", "tags"
end
