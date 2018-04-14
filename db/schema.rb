# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema
# definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more
# migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control
# system.

ActiveRecord::Schema.define(version: 20_180_412_173_457) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'favorite_lists', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_favorite_lists_on_post_id'
    t.index ['user_id'], name: 'index_favorite_lists_on_user_id'
  end

  create_table 'feedbacks', force: :cascade do |t|
    t.boolean 'like'
    t.bigint 'user_id'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_feedbacks_on_post_id'
    t.index ['user_id'], name: 'index_feedbacks_on_user_id'
  end

  create_table 'following_lists', force: :cascade do |t|
    t.integer 'follow_status'
    t.bigint 'to_id'
    t.bigint 'from_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['from_id'], name: 'index_following_lists_on_from_id'
    t.index ['to_id'], name: 'index_following_lists_on_to_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'taggings', id: :serial, force: :cascade do |t|
    t.integer 'tag_id'
    t.string 'taggable_type'
    t.integer 'taggable_id'
    t.string 'tagger_type'
    t.integer 'tagger_id'
    t.string 'context', limit: 128
    t.datetime 'created_at'
    t.index ['context'], name: 'index_taggings_on_context'
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type],
            name: 'taggings_idx', unique: true
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
    t.index %w[taggable_id taggable_type context], name: 'index_taggings_on_tagg
    able_id_and_taggable_type_and_context'
    t.index %w[taggable_id taggable_type tagger_id context], name:
    'taggings_idy'
    t.index ['taggable_id'], name: 'index_taggings_on_taggable_id'
    t.index ['taggable_type'], name: 'index_taggings_on_taggable_type'
    t.index %w[tagger_id tagger_type], name: 'index_taggings_on_tagger_id_and_
    tagger_type'
    t.index ['tagger_id'], name: 'index_taggings_on_tagger_id'
  end

  create_table 'tags', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.integer 'taggings_count', default: 0
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token
    ', unique: true
  end
end
