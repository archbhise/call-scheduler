class CreateDailySurvey < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_surveys do |t|
      t.date :survey_date
      t.integer :total_calories
      t.integer :protein_grams
      t.integer :carbohydrate_grams
      t.integer :fat_grams
      t.integer :fiber_grams
      t.boolean :morning_medications
      t.boolean :evening_medications
      t.float :number_of_coffees
      t.string :scale_api_id
      t.text :json_data
    end
  end
end
