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

ActiveRecord::Schema.define(version: 2021_09_16_100824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.tsvector "tsv_body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
    t.index ["tsv_body"], name: "index_action_text_rich_texts_on_tsv_body", using: :gin
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "article_tags", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id", "tag_id"], name: "index_article_tags_on_article_id_and_tag_id", unique: true
    t.index ["tag_id"], name: "index_article_tags_on_tag_id"
  end

  create_table "article_uploads", force: :cascade do |t|
    t.string "attachment"
    t.text "upload_errors", default: [], array: true
    t.bigint "article_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_article_uploads_on_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "category"
    t.tsvector "tsv_category"
    t.tsvector "tsv_content"
    t.string "status", default: "draft", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tsv_category"], name: "index_articles_on_tsv_category", using: :gin
    t.index ["tsv_content"], name: "index_articles_on_tsv_content", using: :gin
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.tsvector "tsv_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tsv_name"], name: "index_tags_on_tsv_name", using: :gin
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "article_tags", "articles"
  add_foreign_key "article_tags", "tags"
  add_foreign_key "article_uploads", "articles"
  add_foreign_key "articles", "users"

  create_view "articles_searches", sql_definition: <<-SQL
      SELECT articles.id AS article_id,
      articles.category,
      articles.tsv_category,
      action_text_rich_texts.body AS term,
      action_text_rich_texts.tsv_body AS tsv_term,
      array_agg(tags.name) AS tag_names,
      to_tsvector('english'::regconfig, array_to_string(array_agg(tags.tsv_name), ' '::text)) AS tsv_tag_names
     FROM (((articles
       JOIN action_text_rich_texts ON (((action_text_rich_texts.record_id = articles.id) AND ((action_text_rich_texts.record_type)::text = 'Article'::text) AND ((action_text_rich_texts.name)::text = 'content'::text))))
       JOIN article_tags ON ((article_tags.article_id = articles.id)))
       JOIN tags ON ((tags.id = article_tags.tag_id)))
    GROUP BY articles.id, action_text_rich_texts.body, action_text_rich_texts.tsv_body;
  SQL
end
