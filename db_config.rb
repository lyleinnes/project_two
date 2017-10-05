require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'meal_db'
}


ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)

# this will look for the heroku database, if you are running this locally, then it will use options