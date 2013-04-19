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

ActiveRecord::Schema.define(:version => 20130419092501) do

  create_table "affiliates", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.string   "image"
    t.string   "link"
    t.text     "description"
    t.integer  "deleted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "infos", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "app_store"
    t.string   "image"
    t.text     "description"
    t.integer  "deleted"
    t.integer  "priority"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "rss_id"
    t.string   "image_url"
    t.string   "link"
    t.integer  "pubdate"
    t.string   "title"
    t.integer  "tweet_count"
    t.integer  "deleted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "recommends", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.string   "image"
    t.string   "link"
    t.text     "description"
    t.integer  "deleted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rsses", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
