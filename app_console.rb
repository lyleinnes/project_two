require 'pry'
require_relative 'db_config'
# db_config must be above any/all your models because the models rely on active_record which is what db_config references.
require_relative 'models/like'
require_relative 'models/meal'
require_relative 'models/user'





# this file exists so that we can open it in the terminal quickly and play around with our database

binding.pry
