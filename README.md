# README


## Getting started: 30 seconds to call-scheduler

The core data structure of this project is the ``DailySurvey``. Feel free to get setup by running the commands below after setting up your basic rails project.

```ruby
rake db:migrate
```

Next, assign your environment variables. 

```ruby
ENV['OWNER_NAME']="Archit"
ENV['PHONE_NUMBER']="1111111111"
ENV['SCALE_API_ID']="Your API ID"
```
All 3 are needed to successfully make the post call to Scale API which schedules the phone call. [You can obtain your Scale API ID here](https://www.scaleapi.com/).

The easiest way to schedule a phone call is by creating a DailySurvey object:
```ruby
DailySurvey.create(:survey_date=>Date.yesterday)
```
To get this project setup for yourself, I recommend adding a few more columns as you see fit and then modifying the ``DailySurvey`` model and call script in API call.

I've also added a rake task under ``lib/tasks/scheduler.rb`` that can allow the [Heroku Scheduler to run it every day or week as you see fit](https://devcenter.heroku.com/articles/scheduler).
