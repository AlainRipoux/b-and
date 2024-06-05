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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_135029) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "band_messages", force: :cascade do |t|
    t.string "content"
    t.bigint "band_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_band_messages_on_band_id"
    t.index ["user_id"], name: "index_band_messages_on_user_id"
  end

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bands_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "type"
    t.bigint "band_id", null: false
    t.bigint "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_events_on_band_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "first_user_id", null: false
    t.bigint "second_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.index ["first_user_id"], name: "index_invites_on_first_user_id"
    t.index ["second_user_id"], name: "index_invites_on_second_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "invite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invite_id"], name: "index_messages_on_invite_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.bigint "user_id", null: false
    t.string "content"
    t.boolean "done", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_tasks_on_band_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "unavailabilities", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_unavailabilities_on_user_id"
  end

  create_table "user_bands", force: :cascade do |t|
    t.bigint "band_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["band_id"], name: "index_user_bands_on_band_id"
    t.index ["user_id"], name: "index_user_bands_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "nickname"
    t.string "photo"
    t.string "instrument"
    t.string "biography"
    t.string "style"
    t.string "address"
    t.string "availability"
    t.string "frequency"
    t.string "objectives"
    t.string "projects"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "band_messages", "bands"
  add_foreign_key "band_messages", "users"
  add_foreign_key "bands", "users"
  add_foreign_key "events", "bands"
  add_foreign_key "events", "users"
  add_foreign_key "invites", "users", column: "first_user_id"
  add_foreign_key "invites", "users", column: "second_user_id"
  add_foreign_key "messages", "invites"
  add_foreign_key "messages", "users"
  add_foreign_key "tasks", "bands"
  add_foreign_key "tasks", "users"
  add_foreign_key "unavailabilities", "users"
  add_foreign_key "user_bands", "bands"
  add_foreign_key "user_bands", "users"
end
