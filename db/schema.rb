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

ActiveRecord::Schema.define(version: 20160927005544) do

  create_table "daily_surveys", force: :cascade do |t|
    t.date    "survey_date"
    t.integer "total_calories"
    t.integer "protein_grams"
    t.integer "carbohydrate_grams"
    t.integer "fat_grams"
    t.integer "fiber_grams"
    t.boolean "morning_medications"
    t.boolean "evening_medications"
    t.float   "number_of_coffees"
    t.string  "scale_api_id"
    t.text    "json_data"
  end

end
