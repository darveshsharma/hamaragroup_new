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

ActiveRecord::Schema[7.1].define(version: 2025_07_29_154335) do
  create_table "active_admin_comments", charset: "utf8mb3", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "consultation_requests", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.string "service_type"
    t.text "summary"
    t.string "status"
    t.string "supporting_document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "full_name"
    t.string "phone_number"
    t.string "location_of_property"
    t.text "description"
    t.index ["property_id"], name: "index_consultation_requests_on_property_id"
    t.index ["user_id"], name: "index_consultation_requests_on_user_id"
  end

  create_table "document_accesses", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.bigint "document_id", null: false
    t.string "payment_status"
    t.string "payment_id"
    t.decimal "amount", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_accesses_on_document_id"
    t.index ["property_id"], name: "index_document_accesses_on_property_id"
    t.index ["user_id"], name: "index_document_accesses_on_user_id"
  end

  create_table "documents", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.string "document_type"
    t.string "file_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_documents_on_property_id"
  end

  create_table "images", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "property_id", null: false
    t.string "main_image"
    t.string "thumbnail"
    t.string "image1_url"
    t.string "image2_url"
    t.string "image3_url"
    t.string "image4_url"
    t.string "image5_url"
    t.string "image6_url"
    t.string "image7_url"
    t.string "image8_url"
    t.string "image9_url"
    t.string "image10_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_images_on_property_id"
  end

  create_table "membership_payments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", precision: 10
    t.string "payment_status"
    t.string "payment_gateway"
    t.string "transaction_id"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "razorpay_order_id"
    t.index ["user_id"], name: "index_membership_payments_on_user_id"
  end

  create_table "properties", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.string "property_type"
    t.string "subtype"
    t.string "location"
    t.decimal "price", precision: 10
    t.string "dispute_status"
    t.text "dispute_summary"
    t.string "status"
    t.boolean "approved"
    t.string "mutation_document"
    t.string "title_document"
    t.string "aksfard_document"
    t.string "court_case_document"
    t.string "ownership_type"
    t.string "total_area"
    t.string "jamabandi_year"
    t.text "boundaries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "featured", default: false
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_payments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.integer "amount"
    t.string "payment_gateway"
    t.string "transaction_id"
    t.string "payment_status"
    t.string "razorpay_order_id"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "razorpay_payment_id"
    t.index ["property_id"], name: "index_property_payments_on_property_id"
    t.index ["user_id"], name: "index_property_payments_on_user_id"
  end

  create_table "test_enums", charset: "utf8mb3", force: :cascade do |t|
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "membership_status"
    t.boolean "membership_paid"
    t.datetime "membership_paid_at"
    t.integer "role"
    t.boolean "member", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.boolean "profile_completed", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "consultation_requests", "properties"
  add_foreign_key "consultation_requests", "users"
  add_foreign_key "document_accesses", "documents"
  add_foreign_key "document_accesses", "properties"
  add_foreign_key "document_accesses", "users"
  add_foreign_key "documents", "properties"
  add_foreign_key "images", "properties"
  add_foreign_key "membership_payments", "users"
  add_foreign_key "properties", "users"
  add_foreign_key "property_payments", "properties"
  add_foreign_key "property_payments", "users"
end
