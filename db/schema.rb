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

ActiveRecord::Schema.define(version: 20150911213609) do

  create_table "answered_questions", force: :cascade do |t|
    t.integer  "choice_id"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "question_factory_id"
  end

  add_index "answered_questions", ["question_factory_id"], name: "index_answered_questions_on_question_factory_id"

  create_table "choices", force: :cascade do |t|
    t.string   "midi_blob"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order"
    t.boolean  "correct"
  end

  add_index "choices", ["question_id"], name: "index_choices_on_question_id"

  create_table "question_factories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "prompt"
    t.integer  "question_factory_id"
  end

  add_index "questions", ["question_factory_id"], name: "index_questions_on_question_factory_id"

  create_table "scores", force: :cascade do |t|
    t.boolean  "complete",            default: false
    t.integer  "current_streak",      default: 0
    t.integer  "highest_streak",      default: 0
    t.integer  "question_factory_id"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "scores", ["question_factory_id"], name: "index_scores_on_question_factory_id"
  add_index "scores", ["user_id"], name: "index_scores_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
