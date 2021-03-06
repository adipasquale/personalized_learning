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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121216111534) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "choice_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
    t.text     "text"
  end

  create_table "choices", :force => true do |t|
    t.integer  "question_id"
    t.boolean  "right"
    t.string   "text"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "label"
  end

  create_table "exons", :force => true do |t|
    t.string   "slug"
    t.integer  "trait_id"
    t.integer  "task_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "traditional_content"
  end

  create_table "options", :force => true do |t|
    t.string   "value"
    t.integer  "trait_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "name"
    t.integer  "step_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "task_id"
    t.string   "text"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "questionnaire_id"
  end

  create_table "steps", :force => true do |t|
    t.string   "name"
    t.integer  "sequence_order"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "material"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "step_id"
    t.boolean  "is_finalized"
  end

  create_table "traits", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_traits", :force => true do |t|
    t.integer  "user_id"
    t.string   "value"
    t.integer  "trait_id"
    t.integer  "option_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.boolean  "is_admin"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "remember_token"
    t.integer  "step_id"
    t.string   "material_type"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "variations", :force => true do |t|
    t.string   "content"
    t.integer  "exon_id"
    t.integer  "option_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
