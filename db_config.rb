require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'meal_db'
}


ActiveRecord::Base.establish_connection(options)