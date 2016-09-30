desc "This task is called by the Heroku scheduler add-on"

task :schedule_phone_call => :environment do
  survey=DailySurvey.create(:survey_date=>Date.yesterday)
end