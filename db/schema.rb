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

ActiveRecord::Schema.define(version: 20130925115313) do

  create_table "registers", force: true do |t|
    t.integer  "semester_no"
    t.string   "subject_name"
    t.string   "student_id_card"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: true do |t|
    t.string   "student_id_card_no"
    t.string   "student_name"
    t.integer  "semester_no"
    t.string   "subject_no_1"
    t.string   "subject_no_2"
    t.string   "subject_no_3"
    t.string   "subject_no_4"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject_no_5"
  end

  create_table "semesters", force: true do |t|
    t.integer  "semester_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "semesters_subjects", id: false, force: true do |t|
    t.integer "semester_id"
    t.integer "subject_id"
  end

  create_table "subjects", force: true do |t|
    t.string   "subject_name"
    t.integer  "semester_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
