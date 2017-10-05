require 'pry'
require 'sinatra'
# require 'sinatra/reloader'
require 'pg'
require_relative 'db_config'
require_relative 'models/like'
require_relative 'models/meal'
require_relative 'models/user'

enable :sessions #sinatra gives us this functionalty, to log in/out

helpers do
  def current_user
    User.find_by(id: session[:user_id]) #this will return either an id or nil. which is truthy or falsey, so we can use it below in the logged_in? method to check true or false.
  end
  def logged_in?
    if current_user
      return true
    else
      return false
    end
  end
end


get '/' do
  @all_meals = Meal.all.order(created_at: :desc)
  rec_sorted = Meal.all.order(created_at: :desc)
  @rec_meals = rec_sorted.limit(3)
  erb :index
end

get '/profile' do
  sorted = current_user.meals.order(created_at: :desc)
  @meals = sorted.limit(3)
  rec_sorted = Meal.all.order(created_at: :desc)
  @rec_meals = rec_sorted.limit(3)
  erb :profile
end

get '/login' do
  erb :login
end

get '/new_user' do
  erb :new_user
end

get '/all_meals' do
  @all_meals = Meal.all.order(created_at: :desc)
  erb :all_meals
end

post '/new_like' do
  if current_user.likes
    like = Like.new
    like.meal_id = params[:meal_id]
    like.user_id = params[:user_id]
    like.save
  end
  redirect '/'
end

post '/new_meal' do
  meal = Meal.new
  meal.meal_name = params[:meal_name]
  meal.ingredients = params[:ingredients]
  meal.instructions = params[:instructions]
  meal.image_url = params[:image_url]
  meal.user_id = current_user.id
  meal.save
  redirect '/profile'
end

post '/new_user' do
  user = User.new
  user.user_name = params[:username]
  user.email = params[:email]
  user.password = params[:password]
  user.save
  if user.errors.messages == nil
    redirect '/login'
  else
    @username_error = user.errors.messages[:user_name][0]
    @email_error = user.errors.messages[:email][0]
    @password_error = user.errors.messages[:password][0]
    erb :new_user
  end
end

#===============================
# => session functionality below
#===============================

post '/session' do
  user = User.find_by(email: params[:email])
  #if found a user
  if user && user.authenticate(params[:password])
    # successful create session then redirect
    # session = {} imagine this is what a session is. A HASH.
    # we write key/value pairs to the session
    session[:user_id] = user.id
    redirect '/profile'
  else
    @message = 'incorrect email or password'
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end