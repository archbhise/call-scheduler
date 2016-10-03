class DailySurvey < ApplicationRecord

  validates :survey_date, presence: true
  before_create :create_task

  #Called before a task is created, sends a request to the Scale API
  def create_task

    #Assign url
    url="https://api.scaleapi.com/v1/task/phonecall"

    #Auth credentials setup
    auth = {:username=>ENV["SCALE_API_KEY"], :password=>""}
    
    #Assign headers
    headers = {"Content-Type"=>"application/json"}

    #Create payload
    params = {callback_url: 'https://mysterious-ridge-35983.herokuapp.com/survey_callback',
      instruction: "Call this person and ask him his calorie counts for yesterday and the number of coffees he drank. Then, ask him if he took his morning and evening medications.",
      script: "Hey! (pause) How many calories did you eat yesterday? (pause) What about protein grams (pause)?"\
              " What about carbohydrate grams (pause)? What about fat grams (pause)? What about fiber grams (pause)?"\
              " How many coffees did you drink (pause)? Did your take your morning and evening meds (pause)?",
      phone_number: ENV["PHONE_NUMBER"],
      entity_name: ENV["OWNER_NAME"],
      fields: { total_calories: 'Total Calories',
                protein_grams: 'Protein Grams',
                carbohydrate_grams: 'Carbohydrate Grams',
                fiber_grams: 'Fiber Grams',
                fat_grams: 'Fat Grams',
                number_of_coffees: 'Coffees per Day'},
      urgency: "immediate",
      choices: ['only_took_morning_meds', 'only_took_evening_meds', 'took_both_morning_and_evening','no_meds_taken']}

    #Send request
    begin

      request=HTTParty.post(url,:basic_auth=>auth, :headers=> headers, :body=>params.to_json)

      #Receive request and store response
      self.scale_api_id=request["task_id"]
      self.json_data=JSON.dump(request)

    rescue

      #If there's an error, raise an exception to prevent DailySurvey object being created
      raise "Bad Scale API request"
    
    end
    
  end

  #Parse callback from Scale on the survey and assign response to a model
  def parse_response(response)

    if response["outcome"]=="success"

      #Assign calorie counts and grams breakdown
      self.total_calories=response["fields"]["total_calories"].to_i
      self.protein_grams=response["fields"]["total_calories"].to_i
      self.fat_grams=response["fields"]["fat_grams"].to_i
      self.carbohydrate_grams=response["fields"]["carbohydrate_grams"].to_i
      self.fiber_grams=response["fields"]["fiber_grams"].to_i

      #Number of coffees
      self.number_of_coffees=response["fields"]["number_of_coffees"].to_i

      #Assign medications based on response
      if response["choice"]=='only_took_morning_meds'
        self.morning_medications=true
        self.evening_medications=false

      elsif response["choice"]=='only_took_evening_meds'
        self.morning_medications=false
        self.evening_medications=true

      elsif response["choice"]=='took_both_morning_and_evening'
        self.morning_medications=true
        self.evening_medications=true

      else
        self.morning_medications=false
        self.evening_medications=false

      end

      self.save        

    else
      raise "Bad Scale API callback data"
    end

  end

  #Return daily ratios of calories
  def macro_percentages
    
    if self.total_calories!=nil and self.protein_grams != nil and self.carbohydrate_grams!=nil and self.fat_grams!=nil
      return {:protein=>protein_grams.to_f/total_calories, :carbohydrate => carbohydrate_grams.to_f/total_calories, :fat=> fat_grams.to_f/total_calories}
    end

    return nil
  end



end