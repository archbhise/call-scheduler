class SurveyController < ApplicationController

  def parse
    survey=DailySurvey.where(:scale_api_id=>params["task_id"])[0]
    survey.parse_response(params["response"])
  end

end